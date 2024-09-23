import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/model/task_model.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class Updatetasksscreen extends StatefulWidget {
  static const String routeName = 'UpdateTask';
  Updatetasksscreen({super.key});

  @override
  State<Updatetasksscreen> createState() => _UpdatetasksscreenState();
}

class _UpdatetasksscreenState extends State<Updatetasksscreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var pro = Provider.of<Myprovider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Appcolors.blueColor,
        title: Text(
          "Update Tasks ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: pro.isDarkMode()
          ? Appcolors.backgroundDarkColor
          : Appcolors.backgroundLightColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          color: pro.isDarkMode() ? Color(0xff141922) : Appcolors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Edit Task",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: pro.isDarkMode()
                        ? Appcolors.whiteColor
                        : Appcolors.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  initialValue: model.title,
                  onChanged: (value) {
                    model.title = value;
                  },
                  decoration: InputDecoration(
                    labelText: "title",
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: model.description,
                  onChanged: (value) {
                    model.description = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? newDate = await chooseYourDate();
                    if (newDate != null) {
                      model.date = newDate.millisecondsSinceEpoch;
                      setState(() {});
                    }
                  },
                  child: Text(
                    "Selected time",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: pro.isDarkMode()
                          ? Appcolors.whiteColor
                          : Appcolors.blackColor,
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMd().format(DateUtils.dateOnly(
                    DateTime.fromMillisecondsSinceEpoch(model.date ?? 0),
                  )),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: pro.isDarkMode()
                        ? Appcolors.whiteColor
                        : Appcolors.blackColor,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFunction.updateTask(model);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "save Changes",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.blueColor),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
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
    return chosenDate;
  }
}
