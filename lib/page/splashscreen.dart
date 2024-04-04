import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),() {
      Navigator.pushNamed(context, '/homepage');

    });
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
            child: const Text("Smart Parking App",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),)),

      ),
    );
  }
}
