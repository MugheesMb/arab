// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../controller/index_controller.dart';
import 'home_screen.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class StartQuiz extends StatefulWidget {
  final String userName;
  const StartQuiz({super.key, required this.userName});

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentTextStyle: GoogleFonts.mulish(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Quit Quiz?'),
              content: const Text(
                'Are you sure you want exit!!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => exit(0)));
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Consumer<IndexController>(builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF3D434E),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 60), // Add some top padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Text(
                      "Let's do a questionair survey for your chances of having Mental Health Break-down based on answers to the following questions provided. Be honest while answering all of them",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Lottie.asset(
                  'Assets/2.json',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .5,
                  fit: BoxFit.contain,
                ),
                //SizedBox(height: 20), // Adjust this value as needed for spacing
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: SwipeableButtonView(
                      buttonText: 'Slide To Start Test',
                      buttontextstyle:
                          TextStyle(color: Colors.black, fontSize: 17),
                      buttonWidget: Container(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      activeColor: Colors.grey.shade300,
                      isFinished: isFinished,
                      onWaitingProcess: () {
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            isFinished = true;
                          });
                        });
                      },
                      onFinish: () {
                        provider.restartIndexForQuestion();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()));

                        setState(() {
                          isFinished = false;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add some bottom padding
              ],
            ),
          ),
        );
      }),
    );
  }
}
