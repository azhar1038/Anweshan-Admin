import 'package:anweshan_admin/custom_widget/question_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewQuiz extends StatefulWidget {
  @override
  _ReviewQuizState createState() => _ReviewQuizState();
}

class _ReviewQuizState extends State<ReviewQuiz> {
  int questionNumber = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('questions').getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<DocumentSnapshot> questions = snapshot.data.documents;
          DocumentSnapshot s = questions.removeAt(1);
          questions.add(s);
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text('Question${index + 1}'),
                    backgroundColor: Color(0xffe1f5fe),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QuestionDisplay(
                          question: questions[index]['question'],
                          opt1: questions[index]['opt1'],
                          opt2: questions[index]['opt2'],
                          opt3: questions[index]['opt3'],
                          opt4: questions[index]['opt4'],
                          answer: questions[index]['answer'],
                          url: questions[index]['url'],
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
