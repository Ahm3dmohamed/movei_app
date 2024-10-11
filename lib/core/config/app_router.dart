import 'package:flutter/material.dart';
import 'package:movie_app/core/config/page_routes_name.dart';
import 'package:movie_app/modules/layouts/pages/layout_screen.dart';
import 'package:movie_app/modules/layouts/pages/bookmark_tab.dart';
import 'package:movie_app/modules/layouts/pages/home_tab.dart';
import 'package:movie_app/modules/layouts/pages/movei_tab.dart';
import 'package:movie_app/modules/layouts/widgets/search/search_tab.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.initial:
        return MaterialPageRoute(
            builder: (context) => const LayoutScreen(), settings: settings);
      case PageRoutesName.homeTab:
        return MaterialPageRoute(
            builder: (context) => HomeTab(), settings: settings);
      case PageRoutesName.moveiTab:
        return MaterialPageRoute(
            builder: (context) => const MoveiTab(), settings: settings);
      case PageRoutesName.searchTab:
        return MaterialPageRoute(
            builder: (context) => SearchTab(), settings: settings);
      case PageRoutesName.bookMark:
        return MaterialPageRoute(
            builder: (context) => const BookmarkTab(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) =>
                const Center(child: Text("Ther Is No Routes Yaa Broo")),
            settings: settings);
    }
  }
}
