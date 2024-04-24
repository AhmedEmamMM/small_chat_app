import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final Color bgColor;
  final Color hintStyleColors;
  final Color boxShadowColor;
  final Color inputTextColor;
  final TextInputAction textInputAction;
  final TextEditingController controllerr;
  final bool obscuretype;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardTypee;
  final double? width;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    required this.controllerr,
    this.obscuretype = false,
    required this.icon,
    this.keyboardTypee = TextInputType.name,
    this.validator,
    required this.bgColor,
    required this.hintStyleColors,
    this.width,
    this.focusNode,
    this.boxShadowColor = Colors.white,
    this.inputTextColor = Colors.black,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      width: width ?? MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        focusNode: focusNode,
        style: TextStyle(color: inputTextColor),
        textInputAction: textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardTypee,
        obscureText: obscuretype,
        controller: controllerr,
        decoration: InputDecoration(
            icon: icon,
            hintText: hint,
            hintStyle:
                TextStyle(fontWeight: FontWeight.bold, color: hintStyleColors),
            border: InputBorder.none),
        validator: validator,
      ),
    );
  }
}
