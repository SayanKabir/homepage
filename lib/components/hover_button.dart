import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';

class HoverButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double hoverScale;
  final double iconSize;

  const HoverButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    this.hoverScale = 1.4,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onPressed,
          child: AnimatedScale(
            scale: isHovered ? 1.4 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
            child: Blur(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FaIcon(
                    iconData,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          )
        );
      },
    );
  }
}