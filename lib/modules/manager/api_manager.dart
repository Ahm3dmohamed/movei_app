import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/service/models/newrealse_section.dart';
import 'package:movie_app/service/models/recommended_sction.dart';
import 'package:movie_app/service/models/search_model.dart';
import 'package:movie_app/service/models/similer_movei_model.dart';
import 'package:movie_app/service/models/top_side_movei_section.dart';
import 'package:movie_app/service/models/movei_details_model.dart';

// class EndPoints {
//   String mainUrl = "https://api.themoviedb.org/3/movie/";

// }

class ApiManager {
  final String _apiKey = '1d442be9531cc906b3b584d93cfb491c';
  final String _searchApi =
      'https://api.themoviedb.org/3/search/movie?api_key=';

  final String _sideApiSection =
      "https://api.themoviedb.org/3/movie/popular?api_key=";

  final String _newRealseSection =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=";
  final String _recomendedSection =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=";

  Future<TopSideMovei> getTopSideMovei() async {
    try {
      final response = await http.get(Uri.parse('$_sideApiSection$_apiKey'));

      if (response.statusCode == 200) {
        return TopSideMovei.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<NewRealeaseSection> getNewRealseMovei() async {
    try {
      final response = await http.get(Uri.parse('$_newRealseSection$_apiKey'));

      if (response.statusCode == 200) {
        return NewRealeaseSection.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<RecommendedSection> getRecomendedSection() async {
    try {
      final response = await http.get(Uri.parse('$_recomendedSection$_apiKey'));

      if (response.statusCode == 200) {
        return RecommendedSection.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<MoveiDetailsModel> getMoveiDetails(String movieId) async {
    final String topsideDetailsUrl =
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey";

    try {
      final response = await http.get(Uri.parse(topsideDetailsUrl));

      if (response.statusCode == 200) {
        return MoveiDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

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

  Future<SimilarMoviesModel> getSimilarMovies(String movieId) async {
    final String similarMoviesUrl =
        "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$_apiKey";

    final response = await http.get(Uri.parse('$similarMoviesUrl'));

    if (response.statusCode == 200) {
      return SimilarMoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}
