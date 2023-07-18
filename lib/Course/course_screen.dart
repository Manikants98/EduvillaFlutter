import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset('asset/images/aboutus.png'),
        const Text("CoursePage"),
      ],
    ));
  }
}
