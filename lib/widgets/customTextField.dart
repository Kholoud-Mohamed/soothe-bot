import 'package:flutter/material.dart';
// import 'package:validators/validators.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.validator,
  });

  final String? hintText;
  final Function(String)? onChanged;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff87A0A2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 20), // Adjust the padding as needed
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(40), // Adjust the border radius as needed
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 229, 231, 232),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Color(0xff92bec9),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
