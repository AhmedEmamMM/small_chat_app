import 'package:flutter/material.dart';
import 'package:little_chat_app/components/custom_text_field.dart';
import 'package:little_chat_app/core/helpers/helpers.dart';

class ChatRoomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  final FocusNode? focusNode;
  const ChatRoomTextField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      child: Row(
        children: [
          CustomTextField(
            focusNode: focusNode,
            width: 330,
            hint: "Send message",
            controllerr: controller,
            icon: const Icon(Icons.message),
            bgColor: Colors.grey.shade300.withOpacity(0.4),
            hintStyleColors: Colors.white,
          ),
          horizontalSpace(5),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
            child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.arrow_upward_outlined,
                  size: 40,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
