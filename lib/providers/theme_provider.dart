import 'package:flutter/material.dart';
import 'package:take_home_assessment/utils/prefs_keys.dart';

import '../utils/prefs.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = Prefs.getBool(PrefsKeys.isDarkMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Prefs.setBool(PrefsKeys.isDarkMode, _isDarkMode);
    notifyListeners();
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
