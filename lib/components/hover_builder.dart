import 'package:flutter/material.dart';

class HoverBuilder extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;

  const HoverBuilder({super.key, required this.builder});

  @override
  HoverBuilderState createState() => HoverBuilderState();
}

class HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: widget.builder(context, _isHovered),
    );
  }
}
