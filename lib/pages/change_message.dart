import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChangeMessage extends StatefulWidget {
  @override
  _ChangeMessageState createState() => _ChangeMessageState();
}

class _ChangeMessageState extends State<ChangeMessage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  bool _autovalidate = false;
  bool _showForm = false;

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .document('quiz_info/question')
        .get()
        .then((DocumentSnapshot snapshot) {
      _messageController.text = snapshot.data['message'];
      setState(() {
        _showForm = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showForm
        ? Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _messageController,
                    validator: (String val) {
                      if (val.isEmpty)
                        return 'Message cannot be empty';
                      else if (val.trim().length < 5)
                        return 'Message too short.';
                      return null;
                    },
                    autovalidate: _autovalidate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Message',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    child: Text(
                      'Change Message',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    onPressed: _changeMessage,
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void _changeMessage() {
    if (_formKey.currentState.validate()) {
      showWaitDialog();
      Firestore.instance.document('quiz_info/question').updateData({
        'message': _messageController.text,
      }).then((_) {
        Navigator.of(context).pop();
        showSnackbar('Done');
      }).catchError((error) {
        print('Failed to update message: $error');
        showSnackbar('Failed! Try again.');
      });
    }
    setState(() {
      _autovalidate = true;
    });
  }

  void showWaitDialog() {
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
  }

  void showSnackbar(String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
