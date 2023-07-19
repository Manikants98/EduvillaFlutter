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
    if (mounted) {
      setState(() {
        data = dataCourse[0];
      });
    }
  }

  @override
  void initState() {
    if (mounted) {
      courseData();
    }
    super.initState();
  }

  final GlobalKey<ScaffoldState> chapters = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: chapters,
        appBar: AppBar(
          elevation: 20,
          title: Text('${data['heading']}'),
          actions: [
            InkWell(
              onTap: () {
                chapters.currentState!.openEndDrawer();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.menu),
              ),
            )
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  chapters.currentState!.closeEndDrawer();
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  chapters.currentState!.closeEndDrawer();
                },
              ),
            ],
          ),
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
