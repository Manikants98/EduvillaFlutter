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
    List data = await profile();
    setState(() {
      profiles = data[0];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile Data Get Successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '${profiles['name']}',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text('${profiles['email']}'),
            Text('${profiles['gender']}'),
            Text('${profiles['city']}'),
            Text('${profiles['state']}'),
            Text('${profiles['profile_url']}'),
            Text('${profiles['role']}'),
            Text('${profiles['zipcode']}'),
            InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Get.offAll(() => MyHomePage(
                        title: "Edu-Villa™",
                        page: "Home",
                      ));
                },
                child: const Text("Log Out")),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(() => MyHomePage(
                        title: "Edu-Villa™",
                        page: "Update Profile",
                      ));
                },
                child: const Text("Edit Profile"))
          ],
        ),
      ),
    ));
  }
}
