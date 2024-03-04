import 'package:flutter/material.dart';

class DividerImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: 100,
          color: Colors.black26,
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black26,
              width: 1, // Adjust the width of the border as needed
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: AssetImage(
              'images/photo_2024-01-17_04-23-53-removebg-preview.png',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 1,
          width: 105,
          color: Colors.black26,
        ),
      ],
    );
  }
}
