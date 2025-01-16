import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final auth = Supabase.instance.client.auth;

  Future<AuthResponse> login({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Attempt to sign up
      return await auth.signUp(
        email: email,
        password: password,
        data: {'name': name}, // Store the name in user_metadata
      );
    } on AuthException catch (signUpError) {
      if (signUpError.code == 'user_already_exists') {
        try {
          // Sign in if the user already exists
          return await auth.signInWithPassword(
            email: email,
            password: password,
          );
        } on AuthException catch (signInError) {
          throw Exception('Sign-In failed: ${signInError.message}');
        }
      }
      throw Exception('Sign-Up failed: ${signUpError.message}');
    } catch (e) {
      // Catch unexpected errors
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<AuthResponse> signIn(
      {required String name, required String email, required String password}) async {
    return await auth.signInWithPassword(email: email, password: password);
  }
  Future<AuthResponse> signUp({required String name, required String email, required String password}) async {
    return await auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        }
    );
  }
  Future<void> signOut() async {
    await auth.signOut();
  }
  Future<User?> getUser() async {
    final user = auth.currentUser;
    return user;
  }
  Future<String> getName() async {
    final user = auth.currentUser;

    return (user == null) ? "" : user.userMetadata?['name'];
  }
}