// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:mkx/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text("Welcome back! Let's get you signed in."),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50.0,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Your Email',
                        labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50.0,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Your Password',
                        labelText: "Password"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await login(
                          emailController.text, passwordController.text);
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ),
              const Divider(),
              const Text("Don't have an account"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => MyHomePage(
                            title: "Edu-Villa™",
                            page: "Sign Up",
                          ));
                    },
                    child: const Text("Sign Up")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
