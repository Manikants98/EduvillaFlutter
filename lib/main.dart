// ignore_for_file: must_be_immutable, prefer_const_constructors
// unnecessary_non_null_assertion
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkx/APIs/apis.dart';
import 'package:mkx/AboutUs/about_us_screen.dart';
import 'package:mkx/ContactUs/contact_us_screen.dart';
import 'package:mkx/Courses/courses_screen.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.light(primary: Colors.black),
        dividerTheme: DividerThemeData(color: Colors.black26),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.dark(primary: Colors.white),
        dividerTheme: DividerThemeData(color: Colors.white24),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
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
  var isLoading = false;

  void handleChangePage(page) async {
    if (mounted) {
      setState(() {
        currentPage = page;
      });
      scaffoldKey.currentState?.closeDrawer();
    }
  }

  void profileData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      List data = await profile();
      if (data.isNotEmpty) {
        setState(() {
          profiles = data[0];
        });
        setState(() {
          isLoading = false;
        });
      }
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

  final Map<String, Widget> pages = {
    "Profile": const ProfilePage(),
    "About Us": const AboutUsPage(),
    "Contact Us": const ContactUsPage(),
    "Users": const UsersPage(),
    "Courses": const CoursesPage(),
    "Sign Up": const SignUpPage(),
    "Sign In": const SignInPage(),
    "Update Profile": const UpdateProfilePage(),
    "Home": const HomePage(),
  };

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
          splashColor: Colors.transparent,
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
                icon: isLoading
                    ? const CircularProgressIndicator()
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(('${profiles['profile_url']}')),
                        onBackgroundImageError: (exception, stackTrace) =>
                            CircleAvatar(
                                child: Text(
                                    "${profiles['name']?[0].toString().capitalize}")),
                      ),
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
                                radius: 30,
                                backgroundImage:
                                    NetworkImage('${profiles['profile_url']}'),
                                onBackgroundImageError:
                                    (exception, stackTrace) => CircleAvatar(
                                        child: Text(
                                            "${profiles['name']?[0].toString().capitalize}")),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          handleChangePage("Sign Up");
                        },
                        child: const Text(
                          "Sign Up",
                        ),
                      ),
                      const Text("/"),
                      InkWell(
                        onTap: () {
                          handleChangePage("Sign In");
                        },
                        child: const Text(
                          "Sign In",
                        ),
                      ),
                    ],
                  )),
            )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const ListTile(
              title: SizedBox(
                child: Text(
                  "Edu-Villa™",
                  style: TextStyle(
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
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                handleChangePage("Profile");
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_quilt_rounded),
              title: const Text('Courses'),
              onTap: () {
                handleChangePage("Courses");
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Users'),
              onTap: () {
                handleChangePage("Users");
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contact Us'),
              onTap: () {
                handleChangePage("Contact Us");
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text('About Us'),
              onTap: () {
                handleChangePage("About Us");
              },
            ),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: pages[currentPage] ?? pages["Home"],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Welcome Edu-Villa™',
                  style: TextStyle(fontSize: 20),
                ),
                content: Text('This is an example of AlertDialog.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
