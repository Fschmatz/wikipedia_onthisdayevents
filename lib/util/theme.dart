import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: ColorScheme.light(
    primary: Colors.lightBlue.shade800,
    onSecondary: Colors.lightBlue.shade800,
    secondary: Colors.lightBlue.shade800,
  ),
  appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF000000)),
      titleTextStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400, color: Color(0xFF000000))),
  cardTheme: const CardTheme(
    color: Color(0xFFFFFFFF),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFFFFFFF),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFFFFFFFF),
  ),
  bottomAppBarColor: const Color(0xFFFFFFFF),
  snackBarTheme: const SnackBarThemeData(
    actionTextColor: Color(0xFF447DB8),
  ),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF2E3136),
  scaffoldBackgroundColor: const Color(0xFF2E3136),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF447DB8),
    onSecondary: Color(0xFF97bde8),
    secondary: Color(0xFF447DB8),
  ),
  appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFF2E3136),
      backgroundColor: Color(0xFF2E3136),
      //0xFF161617
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF))),
  cardTheme: const CardTheme(
    color: Color(0xFF2E3136),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF2E3136),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFF2E3136),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFF303030),
  ),
  bottomAppBarColor: const Color(0xFF2E3136),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFFF0F0F0),
    actionTextColor: Colors.lightBlue[800],
  ),
);
