import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final bool? obscureText;
  final int? minLength;
  final String? Function(String?)? onValidate;
  final String? incorrectPasswordError;

  PasswordField({
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.minLength,
    this.onValidate,
    this.incorrectPasswordError,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      validator: (data) {
        final validate = widget.onValidate?.call(data);
        if (widget.minLength != null && data!.length < widget.minLength!) {
          return 'Password must be at least ${widget.minLength} characters long';
        }
        return validate ?? (data!.isEmpty ? 'Field is required' : null);
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xff87A0A2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 20), // Adjust the padding as needed
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
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
