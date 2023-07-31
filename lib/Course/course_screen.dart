// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
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

  void commentFn(chapterId) async {
    setState(() {
      isLoading = true;
    });
    List data = await comments(chapterId);

    if (data.toList().isNotEmpty && mounted) {
      setState(() {
        commentsData = data;
      });

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
                    itemBuilder: (context, index) {
                      final item = data['chapters']?[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          selectedTileColor: Colors.black12,
                          selected: item['chapter_id'] == chapter,
                          title: Text(
                            '${item!['chapter_title']}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            setState(() {
                              chapter = item['chapter_id'];
                            });
                            commentFn(data['chapters'][index]['chapter_id']);
                            chapters.currentState!.closeEndDrawer();
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(data['image_url']),
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
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: commentsData?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = commentsData![index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                  item['name'][0].toString().toUpperCase()),
                            ),
                            title: Text(item['name']),
                            subtitle: Text(item['comment']),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
