import 'package:flutter/material.dart';
import 'package:little_chat_app/components/my_drawer.dart';
import 'package:little_chat_app/components/user_tile.dart';
import 'package:little_chat_app/pages/chat_page.dart';
import 'package:little_chat_app/services/auth/auth_service.dart';
import 'package:little_chat_app/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userDate) => _buildUserListItem(userDate, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userDate, BuildContext context) {
    // display all Users except current User
    if (userDate["email"] != authService.getCurrentuser()!.email) {
      return UserTile(
        text: userDate["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userDate["email"],
                  receiverID: userDate["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final sendMessageConttorller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "H O M E   P A G E",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: const MyDrawer(),
        body: _buildUserList(),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/img/29.webp"), fit: BoxFit.fill),
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Column(
        //         children: [],
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
        //         child: Row(
        //           children: [
        //             CustomTextField(
        //               width: 330,
        //               hint: "Send message",
        //               controllerr: sendMessageConttorller,
        //               icon: const Icon(Icons.message),
        //               bgColor: Colors.grey.shade300.withOpacity(0.4),
        //               hintStyleColors: Colors.white,
        //             ),
        //             horizontalSpace(5),
        //             Container(
        //               padding: const EdgeInsets.all(4),
        //               decoration: const BoxDecoration(
        //                   shape: BoxShape.circle, color: Colors.green),
        //               child: IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(
        //                     Icons.arrow_upward_outlined,
        //                     size: 40,
        //                     color: Colors.white,
        //                   )),
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
