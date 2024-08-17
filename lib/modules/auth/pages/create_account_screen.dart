import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/modules/auth/pages/login_screen.dart';

import '../manager/auth_provider.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String routeName = "createAcc";
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Container(
          width: double.infinity,
          // height: double.infinity,
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              image: const DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      const Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: provider.nameController,
                        decoration: InputDecoration(
                            hintText: "Name",
                            labelText: "Name",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.blue),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: provider.phoneController,
                        decoration: InputDecoration(
                            hintText: "Phone",
                            labelText: "Phone",
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.blue),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: provider.emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.blue),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: provider.passwordController,
                        obscureText: provider.isSecure,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  provider.changeSecure();
                                },
                                icon: Icon(provider.isSecure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.blue),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () {
                                  provider.createAccount();
                                },
                                child: const Text("Create Account")),
                          ),
                        ],
                      ),
                       Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text("You have account ..? Login"))
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
