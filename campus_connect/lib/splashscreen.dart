import 'dart:async';

import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/selectuser.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routename = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
// ANIMATION CONTROLLER
  late AnimationController _controller;
  // ANIMATION
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // INITIALING THE CONTROLLER
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // INITIALING THE ANIMATION
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);
    // STARTING THE ANIMATION
    _controller.forward();
    // TIMER FOR SPLASH DURATION
    Timer(const Duration(seconds: 3), () {
      // NAVIAGTING TO LOGIN SCREEN
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => selectUserScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 80, 103, 114),
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Hero(
            tag: "logo",
            child: SizedBox(
                height: 400,
                width: 400,
                child: Image.asset(
                  "assets/CampusConnectcover.png",
                  color: Theme.of(context).indicatorColor,
                )),
          ),
        ),
      ),
    );
  }
}
