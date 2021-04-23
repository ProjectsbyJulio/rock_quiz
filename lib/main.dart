import 'package:flutter/material.dart';
import 'package:rock_quiz/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rock Quiz",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SplashScreen(),
    );
  }
}
