import 'package:flutter/material.dart';
import 'package:little_chat_app/core/helpers/helpers.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                  "assets/img/curves/2d88d8548a6696c76f04eb12dcea8b4b.jpg"),
              fit: BoxFit.fill),
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //icon
            const CircleAvatar(
              child: Icon(Icons.person),
            ),

            horizontalSpace(50),
            // user name
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
