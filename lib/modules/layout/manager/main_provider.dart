import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/core/service/firebase_functions.dart';
import 'package:todo_4pm/modules/layout/pages/settings_screen.dart';
import 'package:todo_4pm/modules/layout/pages/task_screen.dart';

class MainProvider extends ChangeNotifier {
  int selectedIndex = 0;
  DateTime selectedTime = DateTime.now();
  DateTime selectedTimeTask = DateTime.now();
  List<Widget> screens = [TaskScreen(), SettingsScreen()];
  List<String> title = ["Tasks", "Settings"];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  QuerySnapshot<TaskModel?>? tasks;
  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setTime(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void setTimeTask(DateTime time) {
    selectedTimeTask = time;
    notifyListeners();
  }

  void addTask() async {
    TaskModel task = TaskModel(
        title: titleController.text,
        time: selectedTimeTask.millisecondsSinceEpoch,
        desc: descController.text,
        isDone: false);
    await FireBaseFunctions.addTask(task);
    titleController.clear();
    descController.clear();
    notifyListeners();
  }

  Future<QuerySnapshot<TaskModel?>> getTask() async {
    tasks = await FireBaseFunctions.getTask();
    return tasks!;
  }

  void deleteTask(String id)async{
    await FireBaseFunctions.deleteTask(id);
    notifyListeners();
  }
}
