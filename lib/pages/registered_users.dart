import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisteredUsers extends StatefulWidget {
  @override
  _RegisteredUsersState createState() => _RegisteredUsersState();
}

class _RegisteredUsersState extends State<RegisteredUsers> {
  List<DocumentSnapshot> actualList;
  List<DocumentSnapshot> filteredList;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('registered')
        .getDocuments()
        .then((querySnapshot) {
      actualList = querySnapshot.documents;
      filteredList = List.from(actualList);
      setState(() {
        _ready = true;
      });
    });
  }

  Widget searchBox() {
    return Container(
      height: 60,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          hintText: "Search users (case sensitive)",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (val) {
          if (val.isEmpty || val == '') {
            filteredList = List.from(actualList);
          } else {
            filteredList.clear();
            actualList.forEach((snapshot) {
              if (snapshot.data['name'].toString().contains(val) ||
                  snapshot.data['email'].toString().contains(val))
                filteredList.add(snapshot);
            });
          }
          setState(() {});
        },
      ),
    );
  }

  Widget getList() {
    return Expanded(
      child: filteredList == null || filteredList.length == 0
          ? Center(
              child: Text('No one found'),
            )
          : Container(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          filteredList[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          filteredList[index]['email'],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text('Transaction ID:'),
                            Text(filteredList[index]['txnId'] ?? ''),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Approval Ref. Number:'),
                            Text(filteredList[index]['approvalRefNumber'] ?? ''),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Status:'),
                            Text(filteredList[index]['status'] ?? ''),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ready
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              searchBox(),
              getList(),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
