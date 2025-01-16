import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  const Blur({super.key, required this.child, this.blurSigma = 10});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: child,
      ),
    );
  }
}
