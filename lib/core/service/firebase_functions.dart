import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/modules/layout/pages/task_screen.dart';

class FireBaseFunctions {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<TaskModel?> mainFireStore() {
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
    var ref = mainFireStore();
    var docRef = ref.doc();
    task.id = docRef.id;
    await docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel?>> getTask(int time) {
    var ref = mainFireStore();
    var data = ref.where("date", isEqualTo: time).snapshots();
    // var finalData =  data.docs.firstWhere((element) => element.data()!.time == time);
    return data;
  }

  static deleteTask(String id) async {
    var ref = mainFireStore();
    ref.doc(id).delete();
  }

  static setDone(TaskModel model) async {
    var ref = mainFireStore();
    model.isDone = !model.isDone;
    await ref.doc(model.id).update(model.toJson());
  }

  static createAccount(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static login(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
