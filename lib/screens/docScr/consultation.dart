// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pinkgirl/screens/docScr/docdetail.dart';
import 'package:get/get.dart';

import '../../models/doc.dart';
import '../../utilities/Mytheme.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of doctors
    List<Doctor> doctors = [
      Doctor(
        name: "Antonio Russi",
        speciality: "Psychiatrist",
        detail:
            "Prof. Dr. Antonio is known for his compassionate and patient-centered approach to care. He has also been performing advanced psychiatry techniques. Based on existing conditions, he provides customized treatment plans for patients of all age groups. His expertise in advanced psychiatry makes him one of the top certified psychiatrists in Spain.",
        qualifications:
            "MBBS, FCPS ( Psychiatry), M.D. (Psychiatry), Cert in Medical Teaching",
        imageUrl: 'Assets/doc1.jpeg',
      ),
      Doctor(
        name: "Jordi Mones",
        speciality: "Psychiatry",
        detail:
            " Prof. Dr. Jordi Mones is one of the best psychiatrists in spain with a high patient satisfaction rate. She has the following qualifications: MBBS, FCPS, DPM. She continued serving in different psychiatry departments for years treating all kinds of mental health conditions and illnesses. She also works on mental health conditions combining different treatment plans for more effective results against disorders like depression, bipolar disorder, insomnia, eating disorders, post-traumatic stress disorder (PTSD), etc.",
        qualifications: "P.T.S.D  F.C.P.S. , MPhil (Behaviour Science)",
        imageUrl: 'Assets/doc2.jpeg',
      ),
      Doctor(
        name: "Celine Schweighofer",
        speciality: "Wellness Specialist",
        detail:
            "Highly professional psychiatrists like Dr. Celine Schweighofer - Psychiatrist are mental health specialists who have received extensive education and training in the diagnosis, treatment, management, rehabilitation, or prevention of mental health diseases. They provide therapy for mental, behavioral, emotional, and physical aspects of mental disorders. She is a good listener and provides an empathetic environment for the patients to disclose their concerns and life sufferings contributing to their condition. ",
        qualifications: "MBBS, yoga, wellness, Meditation Retreat",
        imageUrl: 'Assets/doc3.jpeg',
      ),
      // Add more doctors here
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: CustomTheme.pinkthemecolor),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            Doctor doctor = doctors[index];
            return InkWell(
              onTap: () {
                Get.to(DocDetail(doctor: doctor)); // Pass doctor to DocDetail
              },
              child: Card(
                color: Color(0xFF3D434E),
                elevation: 20,
                child: Container(
                  height: 110,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(doctor.imageUrl),
                    ),
                    title: Text(
                      doctor.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                        "${doctor.speciality}\n${doctor.qualifications}",
                        style: TextStyle(color: Colors.white60)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
