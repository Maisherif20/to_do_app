import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  Future<void> changeTheme(ThemeMode newThemeMode) async {
    if (currentTheme == newThemeMode) {
      return;
    }
    currentTheme = newThemeMode;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", newThemeMode == ThemeMode.dark); //save Date
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool("isDark");
    if (isDark != null) {
      if (isDark) {
        currentTheme = ThemeMode.dark;
      } else {
        currentTheme = ThemeMode.light;
      }
      notifyListeners();
    }

  }
}
