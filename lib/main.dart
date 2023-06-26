import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool quizMode = false;
  List<Icon> scoreCalculator =[];

  void checkAnswer(bool userPickedAnswer) {
    if (quizBrain.getAnswer() == userPickedAnswer)
      scoreCalculator.add(
          Icon(
            Icons.circle_rounded,
            color: Colors.green,
          )
      );
    else
      scoreCalculator.add(
          Icon(
            Icons.circle_rounded,
            color: Colors.red,
          )
      );
    setState(() {
      quizBrain.getNextQuestion();
      quizMode = true;
    });
  }

  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "QUIZ FINISHED",
      desc: "Thanks for playing this game.",
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                if (quizMode == true && quizBrain.questionNumber == 0) {
                  _onBasicAlertPressed(context);
                  scoreCalculator = [];
                  quizMode = false;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                if (quizMode == true && quizBrain.questionNumber == 0) {
                  _onBasicAlertPressed(context);
                  scoreCalculator = [];
                  quizMode = false;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
      children: scoreCalculator
    ),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
