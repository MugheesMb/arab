// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:pinkgirl/screens/quiz/start_screen.dart';

import '../utilities/Mytheme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'auth/loginPage.dart';
import 'docScr/consultation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'docScr/symptoms.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("User"),
            accountEmail: Text("User@gmail.com"),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Get.to(DashBoard());
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital_outlined),
            title: Text("Consultation"),
            onTap: () {
              Get.to(DoctorScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      )),
      //  Drawer(
      //   backgroundColor: Colors.white,
      //   child: ElevatedButton(
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //       },
      //       child: Text("Signout")),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF3D434E)),
        title: Text(
          "MindVista",
          style: TextStyle(fontSize: 24, color: Color(0xFF3D434E)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
      // bottomNavigationBar: makeBottom,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
              'Assets/map.json',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Your Mental Health Matters",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          MyCard(
                            title: 'Symtoms',
                            desc: "Read about Symptoms",
                            //image: "Assets/2.png",
                            onTap: () {},
                          ),
                          MyCard(
                            title: 'Questionaire Survey',
                            desc: "chevk yourself to get therapist",
                            //  image: "Assets/4.png",
                            onTap: () {
                              Get.to(StartQuiz(userName: ''));
                            },
                          ),
                          MyCard(
                            title: 'Get Consultation',
                            desc: "talk to therapist and get help",
                            //  image: "Assets/4.png",
                            onTap: () {
                              Get.to(DoctorScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: Color.fromARGB(255, 245, 50, 137),
      //     icon: Icon(Icons.healing_outlined),
      //     onPressed: () {
      //       Get.to(Doctor());
      //     },
      //     label: Text("Get Consultation")),
    );
  }
}

class MyCard extends StatelessWidget {
  // final String image;
  final String title;
  final VoidCallback onTap;

  final String desc;

  const MyCard(
      {super.key,
      //    this.image,
      required this.title,
      required this.onTap,
      required this.desc});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Color(0xFF3D434E),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              // leading: Container(
              //   padding: EdgeInsets.only(right: 12.0),
              //   decoration: new BoxDecoration(
              //       border: new Border(
              //           right:
              //               new BorderSide(width: 1.0, color: Colors.black))),
              //   child: Image(image: AssetImage(image)),
              // ),
              title: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Row(
                children: <Widget>[
                  Text(desc, style: TextStyle(color: Colors.white60))
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0)),
        ),
      ),
    );
  }
}
