import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme:  ColorScheme.light(
    primary: Colors.lightBlue.shade800,
    onSecondary: Colors.lightBlue.shade800,
    secondary: Colors.lightBlue.shade800,
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor:  Color(0xFFFFFFFF),
      elevation: 0,
      iconTheme: IconThemeData(
          color: Color(0xFF000000)
      ),
      titleTextStyle:  TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000))),
  cardTheme: const CardTheme(
    color: Color(0xFFFFFFFF),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFFFFFFF),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
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
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF2E3136),
  scaffoldBackgroundColor: const Color(0xFF2E3136),
  colorScheme:  const ColorScheme.dark(
    primary: Color(0xFF447DB8),
    onSecondary: Color(0xFF97bde8),
    secondary: Color(0xFF447DB8),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E3136),//0xFF161617
      iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF)
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFFFF))),
  cardTheme: const CardTheme(
    color: Color(0xFF2E3136),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF2E3136),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
    selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
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