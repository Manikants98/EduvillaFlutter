// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:mkx/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var profiles = {};
  var isLoading = false;

  @override
  void initState() {
    isLoggedInFn();
    super.initState();
  }

  void isLoggedInFn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      profileData();
    } else {
      Get.offAll(() => MyHomePage(
            title: "Edu-Villa™",
            page: "Sign In",
          ));
    }
  }

  void profileData() async {
    setState(() {
      isLoading = true;
    });
    List data = await profile();
    print('$data---data');
    if (data.isNotEmpty) {
      setState(() {
        profiles = data[0];
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            NetworkImage('${profiles['profile_url']}'),
                        onBackgroundImageError: (exception, stackTrace) =>
                            CircleAvatar(
                                child: Text(
                                    "${profiles['name']?[0].toString().capitalize}")),
                        child: Text(
                            "${profiles['name']?[0].toString().capitalize}"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name : ${profiles['name']}',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Email : ${profiles['email']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Gender : ${profiles['gender']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('City : ${profiles['city']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('State : ${profiles['state']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Role : ${profiles['role']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Zipcode : ${profiles['zipcode']}'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.offAll(() => MyHomePage(
                                    title: "Edu-Villa™",
                                    page: "Update Profile",
                                  ));
                            },
                            child: const Text("Edit Profile")),
                      ),
                    ],
                  )
                ],
              ),
      ),
    ));
  }
}
