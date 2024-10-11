import 'package:flutter/material.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/modules/layouts/widgets/search/custom_search_widget.dart';

class SearchTab extends StatelessWidget {
  final ApiManager apiManager = ApiManager();
  SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SearchWidget(),
          
        ],
      ),
    );
  }
}
