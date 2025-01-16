import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClock extends StatefulWidget {
  final double containerOpacity;
  final int position;
  final double size;
  const DigitalClock({super.key, required this.containerOpacity, required this.position, required this.size});

  @override
  DigitalClockState createState() => DigitalClockState();
}

class DigitalClockState extends State<DigitalClock> {

  double fontMultiplier = 50;
  double heightMultiplier = 100;
  double widthMultiplier = 200;

  late String currentTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentTime = _getFormattedTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _getFormattedTime();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return DateFormat('hh:mm').format(now);
    // return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        currentTime,
        style: TextStyle(
          fontSize: fontMultiplier * widget.size,
          fontWeight: FontWeight.w300,
          color: Colors.white.withValues(alpha: 0.9),
          fontFamily: 'RobotoMono',
        ),
    );
  }
}
