// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset('asset/images/aboutus2.png'),
              const Text("About Us",
                  style: TextStyle(
                    fontSize: 25,
                  )),
              Text(
                'Unleash Your Potential with Us!',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Edu-Villa™',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'At Knowledge Academy, we believe that learning has the power to transform lives. Our eLearning platform is designed to provide accessible and high-quality education to learners worldwide. Whether you are a student looking to supplement your studies, a professional seeking to upskill, or an individual eager to explore new topics, we have got something for everyone.')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Mission and Vision',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'Our mission is to democratize education by providing affordable and accessible learning opportunities to learners of all ages and backgrounds. We envision a world where knowledge knows no boundaries, and individuals can unlock their full potential through continuous learning.')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meet Our Expert Instructors',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'At Knowledge Academy, we take pride in our team of expert instructors who bring a wealth of experience and knowledge to our platform. Our instructors are industry professionals, educators, and subject matter experts who are passionate about sharing their expertise with learners. They are committed to creating engaging and interactive courses that cater to different learning styles.')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Unique Learning Experience',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'What sets Knowledge Academy apart is our commitment to delivering a unique learning experience. Our courses are carefully curated to provide comprehensive and practical knowledge. We integrate multimedia elements, quizzes, and hands-on projects to make learning enjoyable and effective. Personalized learning paths and progress tracking ensure that learners stay on track and achieve their goals.')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hear From Our Students',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                      'Do not just take our word for it! Hear what some of our students have to say about their learning journey with Knowledge Academy:'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                      '"I was able to land my dream job after completing the web development course. The practical projects really helped me build a strong portfolio." - John Doe'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                      '"The language courses are amazing! I learned a new language in just a few weeks and now feel confident conversing with native speakers." - Jane Smith'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Partners and Affiliations',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'Knowledge Academy is proud to collaborate with reputable organizations and institutions to offer the best learning experience to our students. Our partnerships enable us to expand our course offerings and provide certifications recognized by industries globally.')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get in Touch',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                    'Have a question or need assistance? We are here to help! Contact our friendly support team at support@eduvilla.com or call us at +918737018483. We value your feedback and suggestions.')
              ],
            ),
          )
        ],
      ),
    ));
  }
}
