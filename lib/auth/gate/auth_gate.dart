import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homepage/auth/views/auth.dart';
import 'package:homepage/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        //LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black.withValues(alpha: 0.7),
                size: 100,
              ),
            ),
          );
        }

        //RETURN AUTH PAGE OR HOME PAGE
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return Home();
        } else {
          return AuthPage();
        }
      },
    );
  }
}
