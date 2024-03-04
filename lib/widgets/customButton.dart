import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff92bec9),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 190,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Langar',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
