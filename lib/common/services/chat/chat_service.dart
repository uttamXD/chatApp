import 'package:chat_app/common/services/chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //get firestore instance and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<void> sendMessage(String receiverId, message) async {
//get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
//create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
//create unique chat room for two chatting users
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids(ensured the chatroomID is the same for any 2 users)
    String chatRoomId = ids.join('_');
//add message to database
    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
  }

  //receive message
  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    //create chat room ID for two chatting users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
