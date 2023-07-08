import 'package:flutter/material.dart';
import 'package:mkx/AboutUs/about_us_screen.dart';
import 'package:mkx/ContactUs/contact_us_screen.dart';
import 'package:mkx/Courses/courses.dart';
import 'package:mkx/Home/home_screen.dart';
import 'package:mkx/Profile/profile.dart';
import 'package:mkx/SignIn/signin_screen.dart';
import 'package:mkx/SignUp/signup_screen.dart';
import 'package:mkx/Users/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = "Home";

  void handleChangePage(page) {
    setState(() {
      currentPage = page;
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (ElevatedButton(
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
                ))),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
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
              child: currentPage == "Home"
                  ? const HomePage()
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
                                          : const ProfilePage())),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
    );
  }
}
