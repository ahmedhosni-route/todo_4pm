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
  TimeOfDay timeOfDay = TimeOfDay.now();
  List<Widget> screens = [TaskScreen(), SettingsScreen()];
  List<String> title = ["Tasks", "Settings"];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  QuerySnapshot<TaskModel?>? tasks;
  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setDate(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }
  void setTime(TimeOfDay time) {
    timeOfDay = time;
    notifyListeners();
  }

  void setTimeTask(DateTime time) {
    selectedTimeTask = time;
    notifyListeners();
  }

  void addTask() async {
    TaskModel task = TaskModel(
        title: titleController.text,
        date: DateUtils.dateOnly(selectedTimeTask).millisecondsSinceEpoch,
        desc: descController.text,
        time: "${timeOfDay.hour} : ${timeOfDay.minute}",
        isDone: false);
    await FireBaseFunctions.addTask(task);
    titleController.clear();
    descController.clear();
    // notifyListeners();
  }

  Stream<QuerySnapshot<TaskModel?>> getTask() {
    return FireBaseFunctions.getTask(DateUtils.dateOnly(selectedTime).millisecondsSinceEpoch) ;

  }

  void deleteTask(String id)async{
    await FireBaseFunctions.deleteTask(id);
    // notifyListeners();
  }

  void setDone(TaskModel model)async{
   await FireBaseFunctions.setDone(model);
   // notifyListeners();
  }
}
