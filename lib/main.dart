import 'package:flutter/material.dart';
import 'package:rock_quiz/splash.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.blueGrey[900],
            statusBarColor: Colors.blueGrey[900]
        )
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rock Quiz",
      home: SplashScreen()
    );
  }
}
