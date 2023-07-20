import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mkx/APIs/apis.dart';

class CoursePage extends StatefulWidget {
  final String course_id;
  const CoursePage({super.key, required this.course_id});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var data = {};
  var chapter = '';

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
      print('$chapter ----Chapter');
    }
    super.initState();
  }

  final GlobalKey<ScaffoldState> chapters = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final chaptersData = data['chapters'];
    final chapterData = chaptersData
        ?.firstWhere((i) => i['chapter_id'] == chapter, orElse: () => null);
    Widget buildChapterDescription(Map<String, dynamic>? chapterData) {
      final chapterDescription = chapterData!['chapter_description'] ?? '';

      return Html(data: chapterDescription);
    }

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
        endDrawer: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Drawer(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    '${data['heading']}',
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data['chapters']?.length,
                    itemBuilder: (context, index) => ListTile(
                      title:
                          Text('${data['chapters'][index]!['chapter_title']}'),
                      onTap: () {
                        setState(() {
                          chapter = data['chapters'][index]['chapter_id'];
                        });
                        chapters.currentState!.closeEndDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
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
                children: [
                  Text('${data['heading']}'),
                  Text('${chapterData!["chapter_title"]}'),
                  Container(
                    child: buildChapterDescription(chapterData),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
