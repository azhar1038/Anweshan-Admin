import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  static Future<bool> checkAdmin(String email, String password) {
    return Firestore.instance
        .collection('admin')
        .where('email', isEqualTo: email)
        .getDocuments()
        .then(
      (querySnapshot) {
        if (querySnapshot == null) return false;
        String realPassword = querySnapshot.documents[0].data['password'];
        if (realPassword == password) return true;
        return false;
      },
    ).catchError((error) {
      throw AuthHelperException(cause: error);
    });
  }

  static Future<void> changePassword(String email, String newPassword) async {
    QuerySnapshot q = await Firestore.instance
        .collection('admin')
        .where('email', isEqualTo: email)
        .getDocuments();
    if (q != null) {
      DocumentReference document = q.documents[0].reference;
      document.updateData({'password': newPassword}).catchError((error) {
        throw AuthHelperException(cause: "FAILED TO UPDATE $error");
      });
    } else {
      throw AuthHelperException(cause: "FAILED TO GET ADMIN DETAILS DOCUMENT.");
    }
  }

  static String emailValidator(String s) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (s.isEmpty || !regex.hasMatch(s))
      return 'Invalid email';
    else
      return null;
  }

  static String passwordValidator(String s) {
    if (s.isEmpty)
      return 'Password cannot be empty';
    else if (s.trim().length < 3) return 'Password too short';
    return null;
  }
}

class AuthHelperException implements Exception {
  String cause;
  AuthHelperException({this.cause});
}
