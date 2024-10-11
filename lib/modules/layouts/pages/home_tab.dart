import 'package:flutter/material.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/modules/layouts/widgets/new_realse/new_realse_widget.dart';
import 'package:movie_app/modules/layouts/widgets/recommended/recommended_widget.dart';
import 'package:movie_app/modules/layouts/widgets/top_side/topside_widget.dart';

class HomeTab extends StatelessWidget {
  final ApiManager apiManager = ApiManager();

  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: TopsideWidget(),
        ),
        Expanded(
          child: NewRealse(),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Expanded(
          child: RecommendedWidget(),
        ),
      ],
    );
  }
}
