// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkgirl/chat/chat_page.dart';
import 'package:pinkgirl/utilities/Mytheme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/doc.dart';

class DocDetail extends StatelessWidget {
  final Doctor doctor;

  const DocDetail({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: CustomTheme.pinkthemecolor),
        title: Text(doctor.name),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(doctor.imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                doctor.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                doctor.speciality,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),
            Text(
              doctor.detail!,
              textAlign: TextAlign.justify,
              style: GoogleFonts.mulish(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Navigate to a chat screen or open a contact form
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(doctor: doctor)),
                  );
                },
                label: Text(
                  "Let's Talk",
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                icon: Icon(
                  Icons.chat,
                  color: Colors.white.withOpacity(.7),
                ),
                backgroundColor: CustomTheme.pinkthemecolor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
