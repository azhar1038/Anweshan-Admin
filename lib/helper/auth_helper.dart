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
    );
  }
}
