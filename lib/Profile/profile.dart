import 'package:flutter/material.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var profiles = {};
  var isLoggedIn = false;
  @override
  void initState() {
    isLoggedInFn();
    if (isLoggedIn) {
      profileData();
    }

    super.initState();
  }

  void isLoggedInFn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${prefs.getString('token')}----Token');
    if (prefs.getString('token').toString().isNotEmpty) {
      print('${prefs.getString('token')}----Tokeeen');
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  void profileData() async {
    List data = await profile();
    setState(() {
      profiles = data[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text('${profiles['name']}'),
      ],
    ));
  }
}
