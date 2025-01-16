import 'package:flutter/material.dart';

class OnboardingTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const OnboardingTextfield({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: 250,
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white, fontSize: 25), // Text color
              cursorColor: Colors.white, // Cursor color
              cursorHeight: 25,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Color of the underline when not focused
                    width: 2.5, // Thickness of the underline when not focused
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Color of the underline when focused
                    width: 2.5, // Thickness of the underline when focused
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Color of the underline when disabled
                    width: 2.5, // Thickness of the underline when disabled
                  ),
                ),
              ),
            ),
          ),
          // MouseRegion(
          //   cursor: SystemMouseCursors.click,
          //   child: GestureDetector(
          //     onTap: onNext, // Trigger the callback when the arrow icon is tapped
          //     child: FaIcon(
          //       FontAwesomeIcons.circleArrowRight,
          //       size: 35,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}