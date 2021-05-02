import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rock_quiz/home.dart';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key key, @required this.marks}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState(marks);
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "assets/img/success.png",
    "assets/img/good.png",
    "assets/img/bad.png"
  ];

  String message, img;

  @override
  void initState() {
    if (marks <= 10) {
      message = "Debes intentarlo con más dedicación :(\nTu puntaje $marks";
    } else if (marks <= 15) {
      message = "Puedes hacerlo mejor!\nTu puntaje $marks";
    } else {
      message = "Felicitaciones!!\nTu puntaje $marks";
    }
    super.initState();
  }

  int marks;
  _ResultPageState(this.marks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Column(
            children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              color: Colors.blueGrey[900],
                child: Container(
                  margin: EdgeInsets.only(top: 190),
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15.0),
                        child: Center(
                            child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20.0, fontFamily: "Poppins300", color: Colors.white),
                        )))
                  ]),
                )),
          ),
          Expanded(
            flex: 5,
            child: Material(

              color: Colors.blueGrey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    },
                    child: Text(
                      "Continuar",
                      style: TextStyle(fontSize: 18.0, fontFamily: "Poppins400", color: Colors.white),
                    ),
                    color: Colors.blueGrey[800],
                    splashColor: Colors.blueGrey[800],
                    highlightColor: Colors.blueGrey[700],
                    minWidth: 250,
                    height: 45,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            )
          )
        ]));
  }
}
