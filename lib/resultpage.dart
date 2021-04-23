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
    if (marks < 10) {
      img = images[2];
      message = "Debes intentarlo con mas dedicacion :(\nTu puntaje $marks";
    } else if (marks < 15) {
      img = images[1];
      message = "Puedes hacerlo mejor!\nTu puntaje $marks";
    } else {
      img = images[0];
      message = "Felicitaciones!!\nTu puntaje $marks";
    }
    super.initState();
  }

  int marks;
  _ResultPageState(this.marks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Resultado")),
        body: Column(children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
                elevation: 10.0,
                child: Container(
                  child: Column(children: <Widget>[
                    Material(
                        child: Container(
                            width: 300.0,
                            height: 300.0,
                            child: ClipRect(
                                child: Image(image: AssetImage(img))))),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15.0),
                        child: Center(
                            child: Text(
                          message,
                          style:
                              TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
                        )))
                  ]),
                )),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    },
                    child: Text(
                      "Continuar",
                      style: TextStyle(fontSize: 18.0, fontFamily: "Raleway"),
                    ),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.indigoAccent)),
              ],
            ),
          )
        ]));
  }
}
