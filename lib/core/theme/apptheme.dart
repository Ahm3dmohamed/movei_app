import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';

class AppTheme {
  static final ThemeData themeLight = ThemeData(
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: const Color(0xff121312),
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyAppColor.btnNavbarColor,
        selectedItemColor: MyAppColor.selectedIconColor,
        unselectedItemColor: MyAppColor.unSelectedIconColor,
      ),
      scaffoldBackgroundColor: MyAppColor.backgroundColor);
}
