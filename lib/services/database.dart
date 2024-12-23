import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addEvent(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('Event')
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllEvents() async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance.collection("Event").snapshots();
  }
}
