import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:little_chat_app/models/message.dart';

class ChatService {
  // get instance of firestore and auth

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return fireStore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each indicidual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = auth.currentUser!.uid;
    final String currentuserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentuserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for two users ( sorted to ensure uniquness)

    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this ensure the chatroomID is the same for any 2 peaple)
    String chatRoomID = ids.join('_');
    // add new message to database
    await fireStore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct chat room ID for two users ( sorted to ensure uniquness)

    List<String> ids = [userID, otherUserID];
    ids.sort(); // sort the ids (this ensure the chatroomID is the same for any 2 peaple)
    String chatRoomID = ids.join('_');

    return fireStore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
