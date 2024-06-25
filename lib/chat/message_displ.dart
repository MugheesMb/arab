import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Message_display extends StatefulWidget {
  const Message_display({super.key});

  @override
  State<Message_display> createState() => _Message_displayState();
}

class _Message_displayState extends State<Message_display> {
  @override
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection("Message")
      .orderBy('time')
      .snapshots();
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot qds = snapshot.data!.docs[index];
              Timestamp time = qds['time'];
              DateTime dateTime = time.toDate();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 300,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.purple,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        title: Text(
                          qds['name'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                qds["message"],
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                            Text("${dateTime.hour}:${dateTime.minute}")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
