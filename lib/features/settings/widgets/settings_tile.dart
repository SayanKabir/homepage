import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';

class SettingsTile extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final bool saved;
  const SettingsTile({super.key, required this.controller, required this.onSubmit, required this.saved});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Make the TextField expandable to fill the available space
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
            ),
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 10), // Add spacing between the TextField and the save icon
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onSubmit,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withValues(alpha: 0.1),
              ),
              child: Blur(
                child: FaIcon(
                  saved
                      ? FontAwesomeIcons.circleCheck
                      : FontAwesomeIcons.circleUp,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
