import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/add_task_Bottom_Sheet.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/login/login.dart';
import 'package:todo_c11_flutter/provider/provider.dart';
import 'package:todo_c11_flutter/tabs/settings/settings.dart';
import 'package:todo_c11_flutter/tabs/tasks.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
        var pro = Provider.of<Myprovider>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: pro.isDarkMode()? Appcolors.backgroundDarkColor :
      Appcolors.backgroundLightColor ,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
        title:  Text(
           "ToDo".tr(),
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton( 
  
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskBottomSheet(),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      bottomNavigationBar: BottomAppBar(  
       color: pro.isDarkMode()? Color(0xff141922) : Appcolors.whiteColor,
        notchMargin: 8,
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar( 
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}
