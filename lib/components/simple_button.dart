import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const MyTextButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
