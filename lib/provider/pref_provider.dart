import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  SharedPreferences? prefs;

  Future setTheme(ThemeMode themeMode) async {
    prefs = await SharedPreferences.getInstance();

    String newTheme = themeMode == ThemeMode.light ? 'Light' : 'Dark';

    await prefs!.setString('theme', newTheme);
  }

  getTheme() async {
    prefs = await SharedPreferences.getInstance();
    final String? newTheme = prefs!.getString('theme');
    if (newTheme != null) {
      mode = newTheme == 'light' ? ThemeMode.light : ThemeMode.dark; 
    }
  }
}
