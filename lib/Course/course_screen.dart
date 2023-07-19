import 'package:flutter/material.dart';
import 'package:mkx/APIs/apis.dart';

class CoursePage extends StatefulWidget {
  final String course_id;
  const CoursePage({super.key, required this.course_id});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var data = {};

  void courseData() async {
    var dataCourse = await course(widget.course_id);
    setState(() {
      data = dataCourse[0];
    });
  }

  @override
  void initState() {
    if (mounted) {
      courseData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 20,
          title: Text('${data['heading']}'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.menu),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Image(
                image: NetworkImage('${data['image_url']}'),
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Loading...'),
              ),
              Column(
                children: [Text('${data['heading']}')],
              ),
            ],
          ),
        ));
  }
}
