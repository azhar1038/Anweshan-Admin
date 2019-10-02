import 'package:anweshan_admin/pages/sign_in.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anweshan Admin',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SignIn(),
    );
  }
}