import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(String newTheme) {
    if (newTheme == 'dark' && appTheme != ThemeMode.dark) {
      appTheme = ThemeMode.dark;
      notifyListeners();
    } else if (newTheme == 'light' && appTheme != ThemeMode.light) {
      appTheme = ThemeMode.light;
      notifyListeners();
    }
  }

  void setTheme(ThemeMode newTheme) {
    if (appTheme != newTheme) {
      appTheme = newTheme;
      notifyListeners();
    }
  }

  void toggleTheme() {
    appTheme = appTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
