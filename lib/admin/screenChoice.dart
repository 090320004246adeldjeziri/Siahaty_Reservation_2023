import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../authentification/login.dart';
import 'connect_admin.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.redAccent,
              Colors.yellow,
              Colors.blueAccent.shade100
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome There!",
                  style: GoogleFonts.luxuriousRoman(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                Text(
                  "Choose one to continue",
                  style: GoogleFonts.actor(
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (() => Get.to(Connection())),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        elevation: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          "ADMIN",
                          style: GoogleFonts.luxuriousRoman(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() => Get.to(LoginPage())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent ,

                       // primary: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        elevation: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          "CLIENT",
                          style: GoogleFonts.luxuriousRoman(
                              color: Colors.white, fontWeight: FontWeight.w900),
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
}
