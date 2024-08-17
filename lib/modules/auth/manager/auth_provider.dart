import 'package:flutter/material.dart';
import 'package:todo_4pm/core/service/firebase_functions.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecure = true;
  changeSecure(){
    isSecure = !isSecure;
    notifyListeners();
  }
  createAccount(){
    FireBaseFunctions.createAccount(emailController.text, passwordController.text);
  } login(){
    FireBaseFunctions.login(emailController.text, passwordController.text);
  }
}