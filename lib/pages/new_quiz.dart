import 'package:anweshan_admin/custom_widget/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index){
        return Column(
          children: <Widget>[
            ExpansionTile(
              title: Text('Question${index+1}'),
              backgroundColor: Color(0xffe1f5fe),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Question(
                    questionReference: Firestore.instance.document('questions/question${index+1}'),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
