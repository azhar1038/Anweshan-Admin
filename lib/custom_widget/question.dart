import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final DocumentReference questionReference;
  final String ques, url, opt1, opt2, opt3, opt4, resetText, submitText;
  final int ans;

  Question({
    @required this.questionReference,
    this.ques,
    this.url,
    this.opt1,
    this.opt2,
    this.opt3,
    this.opt4,
    this.ans,
    this.resetText = 'Reset',
    this.submitText = 'Submit',
  });

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _questionKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _opt1Controller = TextEditingController();
  final TextEditingController _opt2Controller = TextEditingController();
  final TextEditingController _opt3Controller = TextEditingController();
  final TextEditingController _opt4Controller = TextEditingController();
  int _optionValue;
  String _optionError;

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.ques;
    _urlController.text = widget.url;
    _opt1Controller.text = widget.opt1;
    _opt2Controller.text = widget.opt2;
    _opt3Controller.text = widget.opt3;
    _opt4Controller.text = widget.opt4;
    _optionValue = widget.ans;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _questionKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _questionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Question',
              ),
              validator: (String val) {
                if (val.isEmpty || val.trim().length < 3)
                  return "Question is mandatory";
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'ImageUrl',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _opt1Controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Option 1',
              ),
              validator: (String val) {
                if (val.isEmpty || val.trim().length == 0)
                  return "Please enter option";
                else
                  return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _opt2Controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Option 2',
              ),
              validator: (String val) {
                if (val.isEmpty || val.trim().length == 0)
                  return "Please enter option";
                else
                  return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _opt3Controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Option 3',
              ),
              validator: (String val) {
                if (val.isEmpty || val.trim().length == 0)
                  return "Please enter option";
                else
                  return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _opt4Controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Option 4',
              ),
              validator: (String val) {
                if (val.isEmpty || val.trim().length == 0)
                  return "Please enter option";
                else
                  return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text('Select correct option number: '),
            SizedBox(height: 10),
            Wrap(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _optionValue,
                      value: 1,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (int opt) => onOptionSelected(opt),
                    ),
                    Text('1'),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _optionValue,
                      value: 2,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (int opt) => onOptionSelected(opt),
                    ),
                    Text('2')
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _optionValue,
                      value: 3,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (int opt) => onOptionSelected(opt),
                    ),
                    Text('3')
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _optionValue,
                      value: 4,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (int opt) => onOptionSelected(opt),
                    ),
                    Text('4')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _optionError ?? '',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text(widget.resetText),
                  color: Color(0xffff5252),
                  onPressed: _resetQuestion,
                ),
                RaisedButton(
                  child: Text(widget.submitText),
                  color: Color(0xff66bb6a),
                  onPressed: _submitQuestion,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onOptionSelected(int opt) {
    setState(() {
      _optionValue = opt;
    });
  }

  void _resetQuestion() {
    setState(() {
      _questionController.text = '';
      _urlController.text = '';
      _opt1Controller.text = '';
      _opt2Controller.text = '';
      _opt3Controller.text = '';
      _opt4Controller.text = '';
      _optionValue = null;
    });
  }

  void _submitQuestion() {
    if (_questionKey.currentState.validate()) {
      if (_optionValue == null) {
        setState(() {
          _optionError = "Select correct option";
        });
        return;
      }
      setState(() {
        _optionError = null;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      widget.questionReference.updateData(
        {
          'question': _questionController.text,
          'url': _urlController.text,
          'opt1': _opt1Controller.text,
          'opt2': _opt2Controller.text,
          'opt3': _opt3Controller.text,
          'opt4': _opt4Controller.text,
          'answer': _optionValue,
        },
      ).then((_) {
        Navigator.of(context).pop();
      }).catchError(
        (error) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 16.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Error! Try again.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        FlatButton(
                          child: Text('OK'),
                          textColor: Colors.green,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
