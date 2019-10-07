import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: FutureBuilder(
        future: Firestore.instance
            .collection('users')
            .orderBy('tournamentScore', descending: true)
            .getDocuments(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Center(
                child: Text('Failed! Try again.'),
              );
            List<DocumentSnapshot> users = snapshot.data.documents;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  title: Text(users[index]['name']??''),
                  subtitle: Text(
                    users[index].documentID,
                    style: TextStyle(
                      color: Color(0xffaaaaaa),
                    ),
                  ),
                  trailing: Text(users[index]['tournamentScore'].toString(),),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
