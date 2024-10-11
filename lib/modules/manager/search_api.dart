import 'dart:convert';

import 'package:movie_app/service/models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchApiManager {
  final String _apiKey = '1d442be9531cc906b3b584d93cfb491c';
  final String _searchApi =
      'https://api.themoviedb.org/3/search/movie?api_key=';
  Future<SearchModel> getSearchData(String query) async {
    try {
      final response =
          await http.get(Uri.parse('$_searchApi$_apiKey&query=$query'));

      if (response.statusCode == 200) {
        return SearchModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }
}
