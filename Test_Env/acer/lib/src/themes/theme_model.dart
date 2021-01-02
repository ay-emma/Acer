import 'package:acer/src/themes/themes.dart';
import 'package:flutter/material.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = lightTheme;
  ThemeType _themeType = ThemeType.Light;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      notifyListeners();
    } else {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      notifyListeners();
    }
  }
}
