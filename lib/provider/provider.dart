import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/model/useModelr.dart';

class Myprovider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  late User? firebaseUser;
  UserModel? userModel;

  Myprovider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  } 
  
  initUser() async {
    userModel = await FirebaseFunction.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      if (isDark == true) {
        mode = ThemeMode.dark;
      } else {
        mode = ThemeMode.light;
      }
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (mode == themeMode) {
      return;
    }
    mode = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', mode == ThemeMode.dark);
    notifyListeners();
  }

  bool isDarkMode() {
    return mode == ThemeMode.dark;
  }
}
