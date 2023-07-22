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
        chapter = dataCourse[0]?["chapters"]?[0]?['chapter_id'];
      });
      if (data.isNotEmpty) {
        setState(() {
          isLoading = false;
        });
      }
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
        endDrawer: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Drawer(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  horizontalTitleGap: 10,
                  title: Text(
                    '${data['heading']}',
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data['chapters']?.length,
                    itemBuilder: (context, index) => ListTile(
                      textColor:
                          data['chapters'][index]['chapter_id'] == chapter
                              ? Colors.white
                              : Colors.black,
                      tileColor:
                          data['chapters'][index]['chapter_id'] == chapter
                              ? Colors.cyan
                              : Colors.transparent,
                      title:
                          Text('${data['chapters']?[index]!['chapter_title']}'),
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${data['heading']}'),
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
                    ],
                  ),
                ),
              ));
  }
}
