import 'package:flutter/material.dart';
import 'package:todo_c11_flutter/appColors.dart';

class MyThemeMode {
 static ThemeData lightTheme = ThemeData(  
      scaffoldBackgroundColor: Appcolors.backgroundLightColor ,
      
      appBarTheme: 
      AppBarTheme(
        backgroundColor: Appcolors.blueColor ,
        centerTitle: false ,
      ) , 
    
  ); 

  static ThemeData DarkTheme = ThemeData(  
      scaffoldBackgroundColor: Appcolors.backgroundDarkColor ,
      
      appBarTheme: 
      AppBarTheme(
        backgroundColor: Appcolors.blueColor ,
        centerTitle: false ,
      ) , 
    
  );
}
