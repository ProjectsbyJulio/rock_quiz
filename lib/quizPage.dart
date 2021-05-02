import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rock_quiz/resultPage.dart';

class GetJson extends StatelessWidget {
  GetJson();

  String assetToLoad;

  setAsset() {
    assetToLoad = "assets/questions.json";
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    print(assetToLoad);
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assetToLoad, cache: false),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(child: Text("Cargando...")),
          );
        } else {
          return QuizPage(myData: myData);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final List myData;

  QuizPage({Key key, @required this.myData}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {
  final List myData;

  _QuizPageState(this.myData);

  Color colorToShow = Colors.blueGrey[800];
  Color correct = Colors.greenAccent[400];
  Color incorrect = Colors.redAccent[700];
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  int j = 1;
  int timer = 15;
  String showTimer = "15";
  var randomArray;

  Map<String, Color> btnColor = {
    "a": Colors.blueGrey[800],
    "b": Colors.blueGrey[800],
    "c": Colors.blueGrey[800],
    "d": Colors.blueGrey[900]
  };

  bool cancelTimer = false;

  genRandomArray() {
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0;;) {
      distinctIds.add(1 + rand.nextInt(4));
      randomArray = distinctIds.toSet().toList();
      if (randomArray.length < 4) {
        continue;
      } else {
        break;
      }
    }
    print(randomArray);
  }

  @override
  void initState() {
    startTimer();
    genRandomArray();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 15;
    setState(() {
      if (j < 4) {
        i = randomArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks),
        ));
      }
      btnColor["a"] = Colors.blueGrey[800];
      btnColor["b"] = Colors.blueGrey[800];
      btnColor["c"] = Colors.blueGrey[800];
      btnColor["d"] = Colors.blueGrey[800];
      disableAnswer = false;
    });
    startTimer();
  }

  void checkAnswer(String k) {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      marks = marks + 5;
      colorToShow = correct;
    } else {
      colorToShow = incorrect;
    }
    setState(() {
      btnColor[k] = colorToShow;
      cancelTimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Image.asset(
          myData[3][i.toString()][k],
          height: 107,
        ),
        color: btnColor[k],
        splashColor: Colors.blueGrey[700],
        highlightColor: Colors.blueGrey[700],
        minWidth: 120.0,
        height: 105.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Rock Quiz",
                  ),
                  content: Text("No puedes regresar en este momento :("),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Continuar',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][i.toString()],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: "Poppins300",
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: <Widget>[
                          choiceButton('a'),
                          choiceButton('b')
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      Column(
                        children: <Widget>[
                          choiceButton('c'),
                          choiceButton('d')
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Poppins300',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
