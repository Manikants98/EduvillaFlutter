// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mkx/APIs/apis.dart';

class CoursePage extends StatefulWidget {
  final String courseId;
  const CoursePage({super.key, required this.courseId});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var data = {};
  var chapter = '';
  var isLoading = false;
  var commentsData;

  @override
  void initState() {
    if (mounted) {
      courseData();
    }

    super.initState();
  }

  void courseData() async {
    setState(() {
      isLoading = true;
    });
    var dataCourse = await course(widget.courseId);
    if (mounted) {
      setState(() {
        data = dataCourse[0];
        chapter = dataCourse[0]?["chapters"]?[0]?['chapter_id'] ?? "";
      });
      commentFn(dataCourse[0]?["chapters"]?[0]?['chapter_id']);
      if (data.isNotEmpty) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void commentFn(id) async {
    setState(() {
      isLoading = true;
    });
    List data = await comments(id);

    if (data.toString().isNotEmpty && mounted) {
      setState(() {
        commentsData = data;
      });
      print('$data caals');
      setState(() {
        isLoading = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> chapters = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final chaptersData = data['chapters'];
    final chapterData = chaptersData
        ?.firstWhere((i) => i['chapter_id'] == chapter, orElse: () => null);

    return Scaffold(
        key: chapters,
        appBar: AppBar(
          elevation: 20,
          title:
              isLoading ? const Text('Loading...') : Text('${data['heading']}'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data['chapters']?.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Card(
                      color: data['chapters']?[index]?['chapter_id'] == chapter
                          ? Colors.black
                          : Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ListTile(
                        visualDensity: VisualDensity.compact,
                        textColor:
                            data['chapters'][index]['chapter_id'] == chapter
                                ? Colors.white
                                : Colors.black,
                        title: Text(
                          '${data['chapters']?[index]!['chapter_title']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          setState(() {
                            chapter = data['chapters'][index]['chapter_id'];
                          });
                          commentFn(data['chapters'][index]['chapter_id']);
                          chapters.currentState!.closeEndDrawer();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage('${data?['image_url']}'),
                          errorBuilder: (context, error, stackTrace) =>
                              const Text('Loading...'),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${data?['heading']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${chapterData?["chapter_title"]}',
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            HtmlWidget(
                              '${chapterData?["chapter_description"]}',
                            ),
                            HtmlWidget(
                              '${chapterData?["chapter_content"]}',
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: commentsData?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('${commentsData[index]?["name"]}'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
