import 'package:anweshan_admin/helper/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  FocusNode _titleFocus = FocusNode();
  FocusNode _bodyFocus = FocusNode();
  bool _autovalidate = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    focusNode: _titleFocus,
                    controller: _titleController,
                    autovalidate: _autovalidate,
                    validator: (String val){
                      if(val.isEmpty) return 'Title cannot be empty';
                      else if(val.trim().length < 3) return 'Title too short';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term) {
                      _focusChange(_titleFocus, _bodyFocus);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Title',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _bodyFocus,
                    controller: _bodyController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autovalidate: _autovalidate,
                    validator: (String val){
                      if(val.isEmpty) return 'Body cannot be empty';
                      else if(val.trim().length < 3) return 'Body too short';
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      _bodyFocus.unfocus();
                      _submit();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Body',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: Text('Send'),
                onPressed: _submit,
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      String title = _titleController.text;
      String body = _bodyController.text;
      showWaitDialog();
      NotificationHelper.sendToAll(
        title: title,
        body: body,
      ).then((Response response){
        Navigator.of(context).pop();
        if(response.statusCode != 200){
          showSnackbar('[${response.statusCode}] Error message: ${response.body}');
        }else{
          showSnackbar('Done');
        }
      });
    }
    setState(() {
      _autovalidate = true;
    });
  }

  _focusChange(FocusNode from, FocusNode to) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
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
