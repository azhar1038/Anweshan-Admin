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
                    validator: AuthHelper.emailValidator,
                    autovalidate: _autovalidate,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
                    ),
                    validator: AuthHelper.passwordValidator,
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
                      showWaitDialog();
                      AuthHelper.checkAdmin(
                        _emailController.text,
                        _passwordController.text,
                      ).then((bool valid) {
                        Navigator.of(context).pop();
                        if (valid) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context)=>Dashboard(),
                          ),);
                        } else {
                          showSnackBar('Invalid Email or Password!');
                        }
                      }).catchError((error) {
                        Navigator.of(context).pop();
                        showSnackBar('Please check internet connection.');
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

  void showWaitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(String content) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
