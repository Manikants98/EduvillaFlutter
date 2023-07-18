import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkx/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
const baseURL = "https://api-eduvila.onrender.com";

Future register(name, email, password) async {
  try {
    final response = await dio.post('$baseURL/register',
        data: {'name': name, 'email': email, 'password': password});
    Get.offAll(() => MyHomePage(
          title: "Edu-Villa™",
          page: "Sign In",
        ));
    return response;
  } catch (e) {
    throw Exception();
  }
}

Future login(email, password) async {
  try {
    final response = await dio
        .post('$baseURL/login', data: {'email': email, 'password': password});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.data[0]["token"]);
    prefs.setString('user_id', response.data[0]["id"]);
    Get.snackbar('', '${response.data[0]["name"]}, Successfully Logged In',
        boxShadows: [const BoxShadow(color: Colors.black)],
        backgroundColor: (Colors.white),
        snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => MyHomePage(
          title: "Edu-Villa™",
          page: "Home",
        ));
    return response;
  } catch (e) {
    throw Exception();
  }
}

Future<List> profile() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    final response = await dio.get(
      '$baseURL/profile?token=${prefs.getString('token')}',
    );
    print(response);
    List profileData = response.data;

    return profileData;
  } catch (e) {
    print(e);
    throw Exception();
  }
}

Future<List> updateProfile(
    name, gender, country, city, state, phone, profileUrl, zipcode, dob) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await dio.put('$baseURL/profile', data: {
      'id': prefs.getString('user_id'),
      'name': name,
      'gender': gender,
      'country': country,
      'city': city,
      'state': state,
      'phone': phone,
      'profile_url': profileUrl,
      'zipcode': zipcode,
      'dob': dob
    });
    print(response);
    Get.offAll(() => MyHomePage(
          title: "Edu-Villa™",
          page: "Profile",
        ));
    var updateProfile = response.data;
    return updateProfile;
  } catch (e) {
    print(e);
    throw Exception();
  }
}

Future<List> courses() async {
  try {
    final response = await dio.get(
      '$baseURL/courses',
    );
    print('$response-----Courses');
    List courses = response.data;
    return courses;
  } catch (e) {
    print(e);
    throw Exception();
  }
}
