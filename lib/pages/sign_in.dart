import 'package:flutter/material.dart';
import 'package:anweshan_admin/helper/auth_helper.dart';

import 'dashboard.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: _SignInForm(),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Only Admins',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email',
                    ),
                    validator: _validateEmail,
                    autovalidate: _autovalidate,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
                    ),
                    validator: _validatePassword,
                    autovalidate: _autovalidate,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: Text('Continue to Dashboard'),
                onPressed: () {
                  _autovalidate = true;
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      AuthHelper.checkAdmin(
                        _emailController.text,
                        _passwordController.text,
                      ).then((bool valid) {
                        if (valid) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context)=>Dashboard(),
                          ),);
                        } else {
                          showSnackBar('Invalid Email or Password!');
                        }
                      }).catchError((error) {
                        showSnackBar('Server busy. Try again');
                      });
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateEmail(String s) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (s.isEmpty || !regex.hasMatch(s))
      return 'Invalid email';
    else
      return null;
  }

  String _validatePassword(String s) {
    if (s.isEmpty)
      return 'Password cannot be empty';
    else if (s.trim().length < 3) return 'Password too short';
    return null;
  }

  void showSnackBar(String content) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
