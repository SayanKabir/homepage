import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:homepage/user_prefs/providers/user_prefs_provider.dart';

class Greeting extends StatelessWidget {
  final double size;
  const Greeting({super.key, required this.size});

  String getGreetingTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    } else if (hour < 17) {
      return 'afternoon';
    } else {
      return 'evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefsProvider>();

    // if (userPrefs.isLoading) {
    //   return Center(
    //       child: SpinKitPulse(
    //         color: Colors.black.withValues(alpha: 0.7),
    //         size: 100,
    //       ),
    //   );
    // }

    final greetingTime = getGreetingTime();
    final username = userPrefs.username;

    return Text(
      'Good $greetingTime, $username',
      style: TextStyle(
        fontSize: 40 * size,
        fontWeight: FontWeight.w300,
        color: Colors.white.withValues(alpha: 0.9),
        fontFamily: 'RobotoMono',
      ),
    );
  }
}