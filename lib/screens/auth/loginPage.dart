// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pinkgirl/screens/auth/signuppage.dart';
import 'package:get/get.dart';
import 'package:pinkgirl/screens/auth/snack.dart';

import '../../controller/authentication.dart';
import '../../utilities/Mytheme.dart';
import '../dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();
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
                //     painter: MyPainter(50),
                //   ),
                // ),
                // Positioned(
                //   top: size.height * .98,
                //   left: size.width * .1,
                //   child: CustomPaint(
                //     painter: MyPainter(animation4.value - 30),
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
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .2),
                      // child: Lottie.asset(
                      //   'Assets/auth.json',
                      //   width: 350,
                      //   height: 350,
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.1),
                        child: Center(
                          child: Text(
                            'Login',
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
                    SizedBox(
                      height: 70,
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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

                          SizedBox(
                            height: 40,
                          ),
                          MyformField(
                            validator: (String? password) {
                              if (password!.isEmpty) {
                                return 'Password empty';
                              } else if (password.length < 6) {
                                return 'PasswordShort';
                              }
                              return null;
                            },
                            isEmail: false,
                            isPassword: true,
                            controller: passcontroller,
                            icon: Icons.lock_outline,
                            hintText: 'Password...',
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          // component1(
                          //     Icons.email_outlined, 'Email...', false, true),
                          // component1(
                          //     Icons.lock_outline, 'Password...', true, false),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              component2(
                                'LOGIN',
                                2.58,
                                () {
                                  siginmethod();
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                      msg: 'Login button pressed');
                                },
                              ),
                              SizedBox(width: size.width / 20),
                              component2(
                                'Forgotten password!',
                                2.58,
                                () {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                      msg: 'Forgotten password button pressed');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: component2(
                            'Create a new Account',
                            2,
                            () {
                              Get.to(Signup());
                              HapticFeedback.lightImpact();
                              Fluttertoast.showToast(
                                  msg: 'Create a new account button pressed');
                            },
                          ),
                        ),
                        SizedBox(height: size.height * .05),
                      ],
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
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.7)),
            ),
          ),
        ),
      ),
    );
  }

  Future siginmethod() async {
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod()
        .loginUser(email: emailcontroller.text, password: passcontroller.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
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
            validator: validator,
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
