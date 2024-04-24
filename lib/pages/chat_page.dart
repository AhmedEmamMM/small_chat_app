import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:little_chat_app/components/textfield_chatroom.dart';
import 'package:little_chat_app/services/auth/auth_service.dart';
import 'package:little_chat_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final sendMessageConttorller = TextEditingController();

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining spave will be calculated
        // then scroll down
        Future.delayed(
          const Duration(seconds: 2),
          () => scrollDown(),
        );
      }
    });

    // wait a little bit for listview to be build , then scroll to bottom
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    sendMessageConttorller.dispose();
  }

  // scroll controller
  final ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    // if there is something inside the textfield
    if (sendMessageConttorller.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverID, sendMessageConttorller.text);

      // clear the controller
      sendMessageConttorller.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/29.webp"), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildMessageList()),
            ChatRoomTextField(
              focusNode: myFocusNode,
              controller: sendMessageConttorller,
              onTap: sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = authService.getCurrentuser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }

        return ListView(
          controller: scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentuser = data['senderID'] == authService.getCurrentuser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentuser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: isCurrentuser
          ? const EdgeInsets.only(left: 150, top: 5, bottom: 5)
          : const EdgeInsets.only(right: 150, top: 5, bottom: 5),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/img/bg2.jpg"),fit: BoxFit.fill),
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: alignment,
      child: Text(
        data["message"],
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
