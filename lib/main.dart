import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_c11_flutter/login/login.dart';
import 'package:todo_c11_flutter/login/sign_up.dart';
import 'package:todo_c11_flutter/provider/provider.dart';
import 'package:todo_c11_flutter/tabs/updateTasksScreen.dart';
import 'package:todo_c11_flutter/theme_date.dart';
import 'firebase_options.dart';
void main() async {   
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
      runApp(ChangeNotifierProvider(
      create: (context) => Myprovider()..getTheme(),
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [Locale('ar') , Locale('en')],
        child: MyApp())));
}  

  class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);
    return MaterialApp( 
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: pro.mode,
      theme: MyThemeMode.lightTheme,
      darkTheme: MyThemeMode.DarkTheme,
      initialRoute: pro.firebaseUser != null
          ? Homescreen.routeName
          : LoginScreen.routeName,
      routes: {
        Homescreen.routeName: (context) => Homescreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen() ,
        Updatetasksscreen.routeName : (context)=> Updatetasksscreen(),
      },
      debugShowCheckedModeBanner: false, 
    );
  }
}
