import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFFFFF),
  accentColor: Colors.lightBlue[800],
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  appBarTheme: const AppBarTheme(
      backgroundColor:  Color(0xFFF0F0F2),
      elevation: 0,
      iconTheme: IconThemeData(
          color: Color(0xFF151515)
      ),
      titleTextStyle:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000))),
  cardTheme: const CardTheme(
    color: Color(0xFFF1F1F1),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFF9F9F9),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFD0D0D2),
  ),
  accentTextTheme: TextTheme(
    headline1: TextStyle(color: Colors.lightBlue[700]),
    headline2: const TextStyle(color: Color(0xFFF1F1F1)),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFFE9E9E9),
  ),
  bottomAppBarColor: const Color(0xFFC0C0C2),
  snackBarTheme: const SnackBarThemeData(
    actionTextColor: Color(0xFF447DB8),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1B1B1D),
  accentColor: const Color(0xFF447DB8),
  scaffoldBackgroundColor: const Color(0xFF1B1B1D),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF202022),//0xFF161617
      iconTheme: IconThemeData(
          color: Color(0xFFF0F0F0)
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF))),
  cardTheme: const CardTheme(
    color: Color(0xFF303032),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF303030),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
    selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFF1B1B1D),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFF303030),
  ),
  bottomAppBarColor: const Color(0xFF202022),
  accentTextTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xFF97bde8)),
    headline2: TextStyle(color: Color(0xFF000000)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFFF0F0F0),
    actionTextColor: Colors.lightBlue[800],
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
