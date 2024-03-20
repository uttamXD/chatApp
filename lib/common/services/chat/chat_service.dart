import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //get firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get users stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            //go through all users
            final user = doc.data();
            //return users
            return user;
          },
        ).toList();
      },
    );
  }
  //send message

  //receive message
}
