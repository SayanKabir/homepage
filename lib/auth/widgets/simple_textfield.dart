import 'package:flutter/material.dart';

class SimpleTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const SimpleTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // Curved underline border when enabled
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1),
            // borderRadius: BorderRadius.vertical(
            //   bottom: Radius.circular(10), // Curved only at the bottom
            // ),
          ),
          // Thicker curved underline border when focused
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            // borderRadius: BorderRadius.vertical(
            //   bottom: Radius.circular(5), // Curved only at the bottom
            // ),
          ),
        ),
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
