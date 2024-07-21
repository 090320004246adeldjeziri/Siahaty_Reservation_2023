import 'package:cabina/user.dart';
import 'package:cabina/widget/splash_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentification/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentification/inscription.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User users = FirebaseAuth.instance.currentUser!;

  Future<void> signOut(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      // Handle sign out error
      print('Error signing out: $e');
    }
  }

  Future<Userx?> fetchUserByEmail(String email) async {
    Userx? user = await Userx.getUserByEmail(email);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    String userMail = users.email.toString();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 4,
          centerTitle: true,
          title: const Text('My Profile'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  FutureBuilder<Userx?>(
                    future: fetchUserByEmail(userMail),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        Userx? user = snapshot.data;
                        if (user != null) {
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage(user.img),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return const CircleAvatar(
                        radius: 75,
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    users.email.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Navigate to settings screen
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: const Text('Language'),
                    onTap: () {
                      // Navigate to settings screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Terms of Service'),
                    onTap: () {
                      // Navigate to terms of service screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.policy),
                    title: const Text('Privacy Policy'),
                    onTap: () {
                      // Navigate to privacy policy screen
                    },
                  ),
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Aquar Siahi',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signOut;
                    },
                    child: const Text('Sign Out'),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
