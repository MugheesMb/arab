// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/loginPage.dart';
import 'auth/signuppage.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToSignupPage();
  }

  // _navigateToFirstPage() async {
  //
  //   await Future.delayed(const Duration(seconds: 8), () {});
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => StreamBuilder(
  //           stream: FirebaseAuth.instance.authStateChanges(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return CircularProgressIndicator();
  //             } else if (snapshot.hasError) {
  //               return Center(
  //                 child: Text("Something Went wrong"),
  //               );
  //             } else if (snapshot.hasData) {
  //               return DashBoard();
  //             } else {
  //               return Signup();
  //             }
  //           },
  //         ),
  //       ));
  // }

  _navigateToSignupPage() async {
    await Future.delayed(const Duration(seconds: 8), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D434E),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset(
                  'Assets/dov2.jpeg',
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  fit: BoxFit.contain,
                ),
              ),
            ]),
      ),
    );
  }
}
