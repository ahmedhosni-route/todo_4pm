import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/modules/auth/manager/auth_provider.dart';
import 'package:todo_4pm/modules/auth/pages/create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";

  const LoginScreen({super.key});

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
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 30,
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
                                  provider.login();
                                },
                                child: const Text("Login")),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CreateAccountScreen.routeName);
                          },
                          child: const Text(
                              "You dont have account ..? Create Now"))
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
