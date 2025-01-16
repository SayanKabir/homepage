import 'package:flutter/material.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';

class BottomFloatingBar extends StatelessWidget {
  final Widget child;
  final bool autoHideBottomBar;
  const BottomFloatingBar({super.key, required this.child, required this.autoHideBottomBar});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, isHovered) {
        return AnimatedSlide(
          offset: isHovered ? Offset(0, 0) : (autoHideBottomBar ? Offset(0, 1) : Offset(0, 0)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCirc,
          child: AnimatedScale(
            scale: isHovered ? 1.05 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Blur(
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
