import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rock_quiz/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          child: Text(
        "Rock Quiz",
        style: TextStyle(
            fontSize: 60.0, color: Colors.white, fontFamily: "Raleway"),
        textAlign: TextAlign.center,
      )),
    );
  }
}
