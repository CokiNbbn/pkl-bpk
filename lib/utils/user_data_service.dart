import 'package:cloud_firestore/cloud_firestore.dart';

// TODO unused class
class UserDataService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
    await _firestore.collection('users').doc(uid).get();

    return userData.data();
  }
}

