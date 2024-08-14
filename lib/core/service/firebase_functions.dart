import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/modules/layout/pages/task_screen.dart';

class FireBaseFunctions {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<CollectionReference<TaskModel?>> mainFireStore() async {
    return firestore.collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value!.toJson();
      },
    );
  }

  static addTask(TaskModel task) async {
    var ref = await mainFireStore();
    var docRef = ref.doc();
    task.id = docRef.id;
    await docRef.set(task);
  }

  static Future<QuerySnapshot<TaskModel?>> getTask() async {
    var ref = await mainFireStore();
    var data = await ref.get();
    return data;
  }

  static deleteTask(String id) async {
    var ref = await mainFireStore();
    ref.doc(id).delete();
  }
}
