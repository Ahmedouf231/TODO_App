import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/model/task_model.dart';
import 'package:todo_c11_flutter/provider/provider.dart';
import 'package:todo_c11_flutter/tabs/updateTasksScreen.dart';

class TaskItem extends StatelessWidget {
  TaskModel model;
  TaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: pro.isDarkMode() ? Color(0xff141922) : Appcolors.whiteColor,
          borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunction.deleteTask(model.id);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete".tr(),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18), topLeft: Radius.circular(18)),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, Updatetasksscreen.routeName , 
              arguments: model ,
              );
            },
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update".tr(),
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 2,
                color: model.isDone ? Colors.green : Colors.blue,
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: model.isDone
                            ? Colors.green
                            : pro.isDarkMode()
                                ? Appcolors.whiteColor
                                : Appcolors.blackColor,
                      ),
                    ),
                    Text(
                      model.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: pro.isDarkMode()
                            ? Appcolors.whiteColor
                            : Appcolors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              model.isDone
                  ? Text(
                      "Done".tr(),
                      style: TextStyle(color: Colors.green, fontSize: 22),
                    )
                  : IconButton(
                      onPressed: () {
                        model.isDone = true;
                        FirebaseFunction.updateTask(model);
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(80, 40),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
