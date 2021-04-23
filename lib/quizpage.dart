import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rock_quiz/resultpage.dart';

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

  Color colorToShow = Colors.indigoAccent;
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
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent
  };

  bool cancelTimer = false;

  genRandomArray() {
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0;;) {
      distinctIds.add(1 + rand.nextInt(5));
      randomArray = distinctIds.toSet().toList();
      if (randomArray.length < 5) {
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
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    cancelTimer = false;
    timer = 15;
    setState(() {
      if (j < 5) {
        i = randomArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks),
        ));
      }
      btnColor["a"] = Colors.indigoAccent;
      btnColor["b"] = Colors.indigoAccent;
      btnColor["c"] = Colors.indigoAccent;
      disableAnswer = false;
    });
    startTimer();
  }

  void checkanswer(String k) {
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
    Timer(Duration(seconds: 2), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          myData[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Raleway",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Ok :(',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Raleway",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
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
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                    ),
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
