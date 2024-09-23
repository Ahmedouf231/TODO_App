import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/homeScreen.dart';
import 'package:todo_c11_flutter/login/sign_up.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  LoginScreen({Key? key}) : super(key: key);
  var emailContoroller = TextEditingController();
  var passwordContoroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);
    return Scaffold(
      backgroundColor: pro.isDarkMode()
          ? Appcolors.backgroundDarkColor
          : Appcolors.backgroundLightColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?".tr(),
            style: TextStyle(
                color: pro.isDarkMode()
                    ? Appcolors.whiteColor
                    : Appcolors.blackColor),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
            },
            child: Text(
              "SignUp".tr(),
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Login Screen".tr(),
          style: TextStyle(
              color: pro.isDarkMode()
                  ? Appcolors.whiteColor
                  : Appcolors.blackColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField( 
              controller: emailContoroller,
              decoration: InputDecoration(
                labelText: "Email".tr(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordContoroller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password".tr(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseFunction.loginUser(
                    emailContoroller.text, passwordContoroller.text,
                    onError: (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(error),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Okay!"))
                      ],
                    ),
                  );
                }, onSeccess: (label) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Homescreen.routeName, (route) => false,
                      arguments: label);
                });
              },
              child: Text("Login".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
