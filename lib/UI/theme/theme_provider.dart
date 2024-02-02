import 'package:extension_chrome/UI/ui.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

import '../../services/chrome_api.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _gettheme();

  ThemeData _gettheme() {
    getSetting(
        ParameterSendMessage(type: "darkModeGet"), allowInterop((response) {
          themeData = bool.parse(response) ? darkMode : lightMode;
        }));
    return _themeData;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
