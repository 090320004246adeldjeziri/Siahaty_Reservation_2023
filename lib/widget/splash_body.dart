import 'package:cabina/admin/screenChoice.dart';
import 'package:cabina/home_page.dart';
import 'package:cabina/authentification/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:get/get.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Adjust the animation duration to control the splash screen delay
    const SplashBodyDuration = Duration(seconds: 2);
    _controller = AnimationController(
      duration: SplashBodyDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Navigate to the next screen after the splash screen duration
    Future.delayed(SplashBodyDuration).then((_) {
      Get.offAll(() => ChoiceScreen()); // Use Get.offAll for navigation
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slow down the animation for a more beautiful effect
    timeDilation = 1.5;

    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset("assets/images/locas.png"),
        ),
      ),
    );
  }
}
