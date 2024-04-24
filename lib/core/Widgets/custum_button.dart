// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double theWidth;
  final double horizontalPadding;
  final double verticalPadding;
  final double circularBorderRadius;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.theWidth = 285,
    this.horizontalPadding = 110,
    this.verticalPadding = 15,
    this.circularBorderRadius = 15,
    this.color = Colors.amber,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      color: color,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}

class CustomBTN extends StatelessWidget {
  final String text;
  final Color color;
  final double? theWidth;
  final void Function()? onPressed;
  const CustomBTN({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.theWidth = 285,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 55,
        width: theWidth,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )),
        ),
      ),
    );
  }
}
