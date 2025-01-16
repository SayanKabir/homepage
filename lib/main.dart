import 'package:flutter/material.dart';
import 'package:homepage/user_prefs/providers/user_prefs_provider.dart';
import 'package:homepage/auth/gate/auth_gate.dart';
import 'package:homepage/secrets/secrets.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: SUPABASE_PROJECT_URL,
    anonKey: SUPABASE_ANON_KEY,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserPrefsProvider()..loadUserPrefs(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    );
  }
}