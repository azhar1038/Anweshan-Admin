import 'package:anweshan_admin/custom_widget/question_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.document('questions/question6').get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return QuestionDisplay(
            question: snapshot.data['question'],
            opt1: snapshot.data['opt1'],
            opt2: snapshot.data['opt2'],
            opt3: snapshot.data['opt3'],
            opt4: snapshot.data['opt4'],
            answer: snapshot.data['answer'],
            url: snapshot.data['url'],
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}