import 'package:anweshan_admin/helper/auth_helper.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool _autovalidate = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  autovalidate: _autovalidate,
                  validator: AuthHelper.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Your Email',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _currentPasswordController,
                  autovalidate: _autovalidate,
                  validator: AuthHelper.passwordValidator,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Your Current Password',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _newPasswordController,
                  autovalidate: _autovalidate,
                  validator: AuthHelper.passwordValidator,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'New Password',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            error ?? '',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          Expanded(
            child: Container(
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
                child: Text('Change Password'),
                onPressed: () {
                  setState(() async {
                    _autovalidate = true;
                    if (_formKey.currentState.validate()) {
                      showWaitDialog();
                      bool valid = await AuthHelper.checkAdmin(
                        _emailController.text,
                        _currentPasswordController.text,
                      );
                      if (valid) {
                        AuthHelper.changePassword(
                          _emailController.text,
                          _newPasswordController.text,
                        ).then((_){
                          Navigator.of(context).pop();
                          setState(() {
                            error = null;
                          });
                        });
                      } else {
                        Navigator.of(context).pop();
                        setState(() {
                          error = "Email or Current Password is incorrect";
                        });
                      }
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
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
}
