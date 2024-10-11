import 'package:flutter/material.dart';
import 'package:movie_app/core/config/app_router.dart';
import 'package:movie_app/core/config/page_routes_name.dart';
import 'package:movie_app/core/theme/apptheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeLight,
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutesName.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
