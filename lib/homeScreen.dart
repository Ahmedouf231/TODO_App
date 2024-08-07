import 'package:flutter/material.dart';
class Homescreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';
   Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text('ToDo'),
        centerTitle: false,
      ),

    );
  }
}
