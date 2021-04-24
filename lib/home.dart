import 'package:flutter/material.dart';
import 'package:rock_quiz/quizPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget card() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 150, horizontal: 30),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GetJson(),
            ));
          },
          child: Material(
            color: Colors.blueGrey[800],
            elevation: 0,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:40.0,
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        // changing from 200 to 150 as to look better
                        height: 150.0,
                        width: 150.0,
                        child: ClipOval(
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/img/quiz.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Rock Quiz",
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontFamily: "Poppins400",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      "Bienvenido, pondremos a prueba tus conocimientos en esta trivia",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.white,
                          fontFamily: "Poppins300"),
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: <Widget>[card()],
      ),
      backgroundColor: Colors.blueGrey[900],
    );
  }
}
