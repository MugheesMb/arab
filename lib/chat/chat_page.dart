import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinkgirl/chat/message_displ.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/doc.dart';

class ChatPage extends StatefulWidget {
  final Doctor doctor;
  const ChatPage({super.key, required this.doctor});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messsagecontr = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 170,
              child: Message_display(),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: messsagecontr,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Message",
                      enabled: true,
                      contentPadding:
                          EdgeInsets.only(left: 15, bottom: 8, top: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      messsagecontr.text = value!;
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (messsagecontr.text.isNotEmpty) {
                        firebaseFirestore.collection("Message").doc().set({
                          'message': messsagecontr.text.trim(),
                          'time': DateTime.now(),
                          'name': "najib",
                        });
                        messsagecontr.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send_sharp,
                      size: 30,
                      color: Colors.blue,
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
