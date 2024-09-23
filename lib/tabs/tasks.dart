import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/firebase_function.dart';
import 'package:todo_c11_flutter/provider/provider.dart';
import 'package:todo_c11_flutter/taskItem.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: dateTime,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            dateTime = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor,
          dayColor: Colors.blue,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.blue,
          selectableDayPredicate: (date) => date.day != 5,
          locale: 'en',
        ),
        SizedBox(
          height: 24,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFunction.getTasks(dateTime),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text("Error"),
                    ElevatedButton(onPressed: () {}, child: Text("Try again"))
                  ],
                );
              }
              var tasks = snapshot.data?.docs.map((e) => e.data()).toList();
              if (tasks!.isEmpty ?? true) {
                return Text("No tasks" , style: TextStyle(
                  color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor
                ),);
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    model: tasks[index],
                  );
                },
                itemCount: tasks.length,
              );
            },
          ),
        )
      ],
    );
  }
}
