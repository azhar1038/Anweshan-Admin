import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StartQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Text(
            'IMPORTANT! Don\'t do anything with this device after pressing the button.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        RaisedButton(
          child: Text(
            'START QUIZ',
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () => _showAlert(context),
        ),
      ],
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Start Quiz"),
          content: Text('Are you sure you want to start the Quiz?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              textColor: Colors.red,
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Yes'),
              textColor: Colors.green,
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => _QuizCount(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QuizCount extends StatefulWidget {
  @override
  __QuizCountState createState() => __QuizCountState();
}

class __QuizCountState extends State<_QuizCount> {
  bool _canPop = false;
  ValueNotifier<int> _questionNumber = ValueNotifier<int>(-1);
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 18), (Timer timer) {
      if (_questionNumber.value == 11) {
        Firestore.instance.document('quiz_info/question').updateData(
          {'current': -1},
        ).then((_) {
          _questionNumber.value = -1;
          timer.cancel();
          _canPop = true;
        });
      } else {
        Firestore.instance
            .document('quiz_info/question')
            .updateData({'current': FieldValue.increment(1)}).then((_) {
          _questionNumber.value++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Currently Showing: '),
                    ValueListenableBuilder(
                      valueListenable: _questionNumber,
                      builder: (BuildContext context, int value, Widget child) {
                        return Text(
                          value.toString(),
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Text(
                _canPop
                    ? 'You can exit now'
                    : 'Don\'t use this device now. Leave it as it is.',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<bool> _onPop() async {
    if (_canPop)
      return true;
    else
      return false;
  }
}
