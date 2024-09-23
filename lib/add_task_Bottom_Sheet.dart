import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/model/task_model.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
        var pro = Provider.of<Myprovider>(context);

    return Container( 
      color: pro.isDarkMode()?Color(0xff141922) :Appcolors.whiteColor,
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Add New Task".tr(),
            style: TextStyle(fontSize: 20 , color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor) ,
            
          )),
          SizedBox(
            height: 18,
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: "Title".tr(), 
                labelStyle: TextStyle(color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: "Description".tr(),
                 labelStyle: TextStyle(color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
          ),
          Text(
            "Select Date".tr(),
            style: TextStyle(fontSize: 16 ,
            color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              chooseYourDate();
            },
            child: Center(
                child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , 
              color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
            )),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                TaskModel model = TaskModel(
                    date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch,
                    description: descriptionController.text,
                    title: titleController.text ,
                    userId: FirebaseAuth.instance.currentUser?.uid??"",
                    );
                FirebaseFunction.addTask(model).then(
                  (value) {
                    Navigator.pop(context);
                  },
                );
              },
              child: Text(
                "Add".tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  chooseYourDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          const Duration(days: 365),
        ));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}
