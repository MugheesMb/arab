// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinkgirl/chat/chat_page.dart';
import 'package:pinkgirl/screens/auth/snack.dart';

import '../../controller/authentication.dart';
import '../../utilities/Mytheme.dart';
import '../quiz/start_screen.dart';
import 'loginPage.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  TextEditingController name = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    name.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomTheme.pinkthemecolor2,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                // Positioned(
                //   top: size.height * (animation2.value + .58),
                //   left: size.width * .21,
                //   child: CustomPaint(
                //     painter: MyPainter(40),
                //   ),
                // ),
                // Positioned(
                //   top: size.height * .98,
                //   left: size.width * .1,
                //   child: CustomPaint(
                //     painter: MyPainter(animation4.value - 60),
                //   ),
                // ),
                // Positioned(
                //   top: size.height * .5,
                //   left: size.width * (animation2.value + .8),
                //   child: CustomPaint(
                //     painter: MyPainter(30),
                //   ),
                // ),
                // Positioned(
                //   top: size.height * animation3.value,
                //   left: size.width * (animation1.value + .1),
                //   child: CustomPaint(
                //     painter: MyPainter(60),
                //   ),
                // ),
                // Positioned(
                //   top: size.height * .1,
                //   left: size.width * .8,
                //   child: CustomPaint(
                //     painter: MyPainter(animation4.value),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * .2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            'Mental health \nis wealth',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyformField(
                              validator: (String? email) {
                                if (email!.isEmpty) {
                                  return 'enter name';
                                }
                              },
                              isEmail: true,
                              isPassword: false,
                              controller: name,
                              icon: Icons.person,
                              hintText: 'Name',
                            ),
                            MyformField(
                              validator: (String? email) {
                                if (email!.isEmpty) {
                                  return 'enter email';
                                }
                              },
                              isEmail: true,
                              isPassword: false,
                              controller: emailcontroller,
                              icon: Icons.email_outlined,
                              hintText: 'Email...',
                            ),
                            MyformField(
                              validator: (String? pass) {
                                if (pass!.length < 8) {
                                  return 'enter 8 digits';
                                }
                              },
                              isEmail: false,
                              isPassword: true,
                              controller: passcontroller,
                              icon: Icons.lock_outline,
                              hintText: 'Password...',
                            ),
                            component2(
                              'Signup',
                              2,
                              () {
                                signupmethod();

                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                    msg: 'Create a new account button pressed');
                              },
                            ),

                            // component1(
                            //     Icons.email_outlined, 'Email...', false, true),
                            // component1(
                            //     Icons.lock_outline, 'Password...', true, false),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Already Have an Account?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(.7),
                                      fontWeight: FontWeight.normal),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(LoginPage());
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 23,
                                        color: Colors.white.withOpacity(.7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signupmethod() async {
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailcontroller.text,
        password: passcontroller.text,
        name: name.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      // navigate to the next screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StartQuiz(userName: name.text),
      ));
      // Get.to();
      // Get.to();
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.09),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
              colors: [Color(0xff74c6f1), Color(0xff378de3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyformField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool? isPassword;
  final bool? isEmail;
  final String? Function(String?) validator;

  const MyformField(
      {super.key,
      this.isEmail,
      this.isPassword,
      required this.controller,
      required this.icon,
      required this.hintText,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.09),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword!,
            keyboardType:
                isEmail! ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.9)),
            ),
          ),
        ),
      ),
    );
  }
}
