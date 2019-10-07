import 'package:anweshan_admin/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _txnIdController = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _txnIdFocus = FocusNode();
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
                    focusNode: _emailFocus,
                    controller: _emailController,
                    autovalidate: _autovalidate,
                    validator: AuthHelper.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term) {
                      _focusChange(_emailFocus, _nameFocus);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email of Contestant',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _nameFocus,
                    controller: _nameController,
                    autovalidate: _autovalidate,
                    validator: (String val) {
                      if (val.isEmpty)
                        return "Name is Required";
                      else if (val.trim().length < 3) return "Name too short";
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term) {
                      _focusChange(_nameFocus, _txnIdFocus);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Name of Contestant',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _txnIdFocus,
                    controller: _txnIdController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term) {
                      _txnIdFocus.unfocus();
                      _submit();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Transaction ID',
                      helperText: '(If Available)',
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
                child: Text('Register'),
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
      String email = _emailController.text;
      String name = _nameController.text;
      String txnId = _txnIdController.text;
      showWaitDialog();
      Firestore.instance.collection('registered').document().setData(
        {
          'email': email,
          'name': name,
          'txnId': txnId,
          'approvalRefNumber': null,
          'photoUrl': null,
          'status': 'offline',
        },
      ).then((_) {
        Navigator.of(context).pop();
        showSnackbar('Done');
      }).catchError((error) {
        print('Failed to register: $error');
        Navigator.of(context).pop();
        showSnackbar('Failed! Try again.');
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
