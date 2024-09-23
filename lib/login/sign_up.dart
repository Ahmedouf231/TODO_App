import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/login/login.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = 'SignUp';
  SignUpScreen({Key? key}) : super(key: key);
  var emailContoroller = TextEditingController();
  var passwordContoroller = TextEditingController();
  var ageContoroller = TextEditingController();
  var phoneContoroller = TextEditingController();
  var userNameContoroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: pro.isDarkMode()
          ? Appcolors.backgroundDarkColor
          : Appcolors.backgroundLightColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("SignUp Screen".tr()),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                 if (value == null) {
                    return "please enter email Adress ";
                  }
                  final bool emailValid = RegExp(
                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "please enter email format ";
                  }
                  return null;   
                },
                controller: emailContoroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email".tr(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " please enter your password ";
                  } 
                },
                controller: passwordContoroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password".tr(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " please enter User Name ";
                  }
                },
                controller: userNameContoroller,
                decoration: InputDecoration(
                  labelText: "User Name".tr(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " please enter your phone";
                  }
                  return null;
                },
                controller: phoneContoroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone".tr(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                    if (value == null || value.isEmpty) {
                    return " please enter Your age ";
                  }
                },
                controller: ageContoroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Age".tr(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFunction.createAccountAuth(
                        emailContoroller.text, passwordContoroller.text,
                        age: int.parse(ageContoroller.text),
                        phone: phoneContoroller.text,
                        userName: userNameContoroller.text, onError: (error) {
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
                                child: Text("Okay!")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"))
                          ],
                        ),
                      );
                    }, onSeccess: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    });
                  }
                },
                child: const Text('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
