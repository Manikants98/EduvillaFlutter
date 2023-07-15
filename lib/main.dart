// ignore_for_file: must_be_immutable
// unnecessary_non_null_assertion
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:mkx/AboutUs/about_us_screen.dart';
import 'package:mkx/ContactUs/contact_us_screen.dart';
import 'package:mkx/Courses/courses.dart';
import 'package:mkx/Home/home_screen.dart';
import 'package:mkx/Profile/profile.dart';
import 'package:mkx/SignIn/signin_screen.dart';
import 'package:mkx/SignUp/signup_screen.dart';
import 'package:mkx/UpdateProfile/update_profile_screen.dart';
import 'package:mkx/Users/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // colorScheme: const ColorScheme.dark(),

        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    required this.title,
    this.page,
  });
  final String title;
  String? page;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = "Home";
  var isLoggedIn = false;
  var profiles = {};

  void handleChangePage(page) async {
    setState(() {
      currentPage = page;
    });
  }

  void profileData() async {
    List data = await profile();
    if (data.isNotEmpty) {
      setState(() {
        profiles = data[0];
      });
    }
  }

  @override
  void initState() {
    isLoggedInFn();
    setState(() {
      widget.page.toString().isEmpty
          ? currentPage == "Home"
          : currentPage = widget.page.toString();
    });
    super.initState();
  }

  void isLoggedInFn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((prefs.getString('token') != null)) {
      setState(() {
        isLoggedIn = true;
        profileData();
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 10,
        title: InkWell(
          onTap: () {
            handleChangePage("Home");
          },
          child: const Text("Edu-Villa™",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          if (isLoggedIn)
            PopupMenuButton(
                position: PopupMenuPosition.under,
                offset: const Offset(11, 11),
                icon: CircleAvatar(
                    backgroundImage:
                        NetworkImage(('${profiles['profile_url']}')),
                    onBackgroundImageError: (exception, stackTrace) =>
                        CircleAvatar(
                            child: Text(
                                "${profiles['name']?[0].toString().capitalize}")),
                    child:
                        Text("${profiles['name']?[0].toString().capitalize}")),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      padding: const EdgeInsets.all(0),
                      value: 0,
                      child: SizedBox(
                        child: Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage('${profiles['profile_url']}'),
                                onBackgroundImageError:
                                    (exception, stackTrace) => CircleAvatar(
                                        child: Text(
                                            "${profiles['name']?[0].toString().capitalize}")),
                                child: Text(
                                    "${profiles['name']?[0].toString().capitalize}"),
                              ),
                              Text("${profiles['name']}"),
                              Text("${profiles['email']}"),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      padding: EdgeInsets.all(2),
                      value: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person),
                          ),
                          Text("My Account"),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      padding: EdgeInsets.all(2),
                      value: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.settings),
                          ),
                          Text("Setting"),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      padding: EdgeInsets.all(2),
                      value: 2,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.exit_to_app),
                          ),
                          Text("Log Out"),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 0) {
                    handleChangePage("Profile");
                  } else if (value == 1) {
                    print("Settings menu is selected.");
                  } else if (value == 2) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Get.offAll(() => MyHomePage(
                          title: "Edu-Villa™",
                          page: "Home",
                        ));
                  }
                })
          else
            ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        handleChangePage("Sign Up");
                      },
                      child: const Text("Sign Up"),
                    ),
                    const Text("/"),
                    InkWell(
                      onTap: () {
                        handleChangePage("Sign In");
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const ListTile(
              title: SizedBox(
                child: Text(
                  'EduVilla',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                handleChangePage("Home");
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                handleChangePage("Profile");
                print(isLoggedIn);
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_quilt_rounded),
              title: const Text('Courses'),
              onTap: () {
                handleChangePage("Courses");
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Users'),
              onTap: () {
                handleChangePage("Users");
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contact Us'),
              onTap: () {
                handleChangePage("Contact Us");
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text('About Us'),
              onTap: () {
                handleChangePage("About Us");
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: Center(
              child: currentPage == "Profile"
                  ? const ProfilePage()
                  : currentPage == "About Us"
                      ? const AboutUsPage()
                      : currentPage == "Contact Us"
                          ? const ContactUsPage()
                          : currentPage == "Users"
                              ? const UsersPage()
                              : currentPage == "Courses"
                                  ? const CoursesPage()
                                  : currentPage == "Sign Up"
                                      ? const SignUpPage()
                                      : currentPage == "Sign In"
                                          ? const SignInPage()
                                          : currentPage == "Update Profile"
                                              ? const UpdateProfilePage()
                                              : const HomePage())),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
    );
  }
}
