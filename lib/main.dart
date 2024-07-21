import 'dart:async';
import 'package:cabina/authentification/login.dart';
import 'package:cabina/profile.dart';
import 'package:cabina/features/splash/splash_view.dart';
import 'package:cabina/widget/splash_body.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'cabine_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(builder: (context) => const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    fetchDataFromFirestore();
    return const GetMaterialApp(
      builder: DevicePreview
          .appBuilder, // TODO: You should decide what to do with this
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      title: 'Aquarek Siahi',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 0),
      () {
        Get.off(() =>
            const SplashBody()); // Use Get.off to navigate and replace the current page
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // You might want to return a placeholder widget here for now
    return const SplashBody(); // any problem replace it with container !!
  }
}
