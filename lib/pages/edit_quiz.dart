import 'package:anweshan_admin/custom_widget/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditQuiz extends StatelessWidget {

  Widget getQuestionList(List<DocumentSnapshot> questions){
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index){
        DocumentSnapshot question = questions[index];
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
                    ques: question['question'],
                    opt1: question['opt1'],
                    opt2: question['opt2'],
                    opt3: question['opt3'],
                    opt4: question['opt4'],
                    url: question['url'],
                    ans: question['answer'],
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('questions').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){
        if(querySnapshot.connectionState == ConnectionState.active || querySnapshot.connectionState == ConnectionState.waiting){
          if(querySnapshot.hasError){
            return Center(child: Text('Failed to connect to server.'),);
          }
          else if(querySnapshot.hasData){
            List<DocumentSnapshot> questions = querySnapshot.data.documents;
            DocumentSnapshot q = questions.removeAt(1);
            questions.add(q);
            return getQuestionList(questions);
          }
          
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}