// lib/theme_model.dart
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  MaterialColor _mainColor = Colors.purple;

  bool get isDark => _isDark;
  MaterialColor get mainColor => _mainColor;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void changeMainColor(MaterialColor color) {
    _mainColor = color;
    notifyListeners();
  }
}
