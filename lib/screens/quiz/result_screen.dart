// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinkgirl/screens/docScr/consultation.dart';
import 'package:pinkgirl/screens/dashboard.dart';
import 'package:pinkgirl/utilities/Mytheme.dart';
import 'package:provider/provider.dart';
import '../../../controller/index_controller.dart';
import 'start_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key, required this.marksEarnedFromQuiz});

  int marksEarnedFromQuiz = 0;

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
                'Are you sure you want exit!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Color(0xFF3D434E), fontSize: 16),
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
      child: Consumer<IndexController>(
          builder: (context, getIndexProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFF3D434E),
          appBar: AppBar(
            backgroundColor: Color(0xFF3D434E),
            leading: marksEarnedFromQuiz > 4
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                contentTextStyle: GoogleFonts.mulish(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Back to home?',
                                ),
                                content: const Text(
                                  'Are you sure want to\nrestart the quiz',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text(
                                      'NO',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(66, 130, 241, 1)),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StartQuiz(userName: ''))),
                                    child: const Text(
                                      'YES',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(66, 130, 241, 1)),
                                    ),
                                  ),
                                ],
                              ));
                    },
                  )
                : const SizedBox(),
            centerTitle: true,
            title: Text(
              '',
              style: GoogleFonts.mulish(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                fontSize: 20,
              ),
            ),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Ancipating your answers,we have predicted',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      color: CustomTheme.greythemecolor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      fontSize: 25,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 149.33,
                      height: 149.33,
                      child: CircularPercentIndicator(
                        backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
                        animation: true,
                        radius: 70,
                        lineWidth: 13.0,
                        percent: marksEarnedFromQuiz / 10,
                        animationDuration: 1000,
                        reverse: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "$marksEarnedFromQuiz/10",
                          style: GoogleFonts.mulish(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                            fontSize: 15,
                          ),
                        ),
                        progressColor: marksEarnedFromQuiz > 4
                            ? Color.fromARGB(255, 230, 97, 14)
                            : const Color.fromRGBO(82, 186, 0, 1),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    marksEarnedFromQuiz < 5
                        ? Column(
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'It seems, You are not at a risk of having any Mental Break-down at present, but still if you want to Consult the Therapist, yo can.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: -0.3,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text(
                                  'You are at a high risk of Mental Break-Down and are suggested to consult the therapist as soon as possible, click below for suggested therapist.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.3,
                                    fontSize: 15,
                                  ),
                                )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomTheme.greythemecolor),
                                  onPressed: () {
                                    Get.to(DoctorScreen());
                                  },
                                  child: Text(
                                    "Consult with Therapist",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ))
                            ],
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    marksEarnedFromQuiz > 5
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 1,
                            ),
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomTheme.greythemecolor),
                                  onPressed: () {
                                    Get.to(DashBoard());
                                  },
                                  icon: Icon(
                                    Icons.dashboard,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Move to Dashboard',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomTheme.greythemecolor),
                                  onPressed: () {
                                    Get.to(StartQuiz(userName: ''));
                                  },
                                  icon: Icon(
                                    Icons.restart_alt,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  label: Text(
                                    'Test to yourself again',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              top: 1,
                            ),
                            child: Column(
                              children: [
                                // Container(
                                //   width: 160,
                                //   height: 60,
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(20)),
                                //   child: Text(
                                //     'Congratulations\n You are saved',
                                //     textAlign: TextAlign.center,
                                //     style: GoogleFonts.mulish(
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w700,
                                //       letterSpacing: -0.3,
                                //       fontSize: 15,
                                //     ),
                                //   ),
                                // ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomTheme.greythemecolor),
                                  onPressed: () {
                                    Get.to(DashBoard());
                                  },
                                  icon: Icon(
                                    Icons.dashboard,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Move to Dashboard',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomTheme.greythemecolor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // Adjust the radius as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(StartQuiz(userName: ''));
                                  },
                                  icon: Icon(
                                    Icons.restart_alt,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  label: Text(
                                    'Test to yourself again',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
