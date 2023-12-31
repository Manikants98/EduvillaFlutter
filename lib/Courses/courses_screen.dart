// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:mkx/Course/course_screen.dart';
import 'package:shimmer/shimmer.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  var coursesData = [];
  var isLoading = false;

  void coursesFn() async {
    setState(() {
      isLoading = true;
    });
    List data = await courses();
    if (data.isNotEmpty && mounted) {
      setState(() {
        coursesData = data;
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    coursesFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? SizedBox(
              height: 800,
              child: Shimmer.fromColors(
                period: Duration(seconds: 2),
                baseColor: Color.fromRGBO(207, 207, 207, 1),
                highlightColor: Color.fromRGBO(210, 210, 210, 1),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.67),
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: [
                      1,
                      2,
                      4,
                      5,
                      6,
                      7,
                    ].length,
                    itemBuilder: (context, index) {
                      return const Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      );
                    }),
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: 800,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.67),
                  padding: const EdgeInsets.only(bottom: 40),
                  itemCount: coursesData.length,
                  itemBuilder: (context, index) {
                    final item = coursesData[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoursePage(
                                courseId: item?['id'],
                              ),
                            ));
                      },
                      splashColor: Colors.transparent,
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 0.4,
                                margin: const EdgeInsets.all(0),
                                clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0))),
                                child: Image(
                                    image: NetworkImage(item?['image_url']),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Text('Loading...')),
                              ),
                              const SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  '${item['category']}'.toUpperCase(),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  item['heading'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
