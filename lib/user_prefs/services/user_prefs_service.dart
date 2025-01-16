import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:homepage/user_prefs/models/user_prefs_model.dart';

class UserPrefsService {
  final prefsTable = Supabase.instance.client.from('user_prefs');
  final auth = Supabase.instance.client.auth;

  // Upsert (Insert or Update) User Preferences
  Future<void> upsertUserPref({
    required String tag,
    required String value,
  }) async {
    try {
      final userId = auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in.');
      }

      await prefsTable.upsert({
        'user_id': userId,
        'tag': tag,
        'value': value,
      });
    } catch (e) {
      throw Exception('Failed to upsert user preference: $e');
    }
  }

  // Fetch a Specific User Preference
  Future<String?> fetchUserPref(String tag) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in.');
      }

      final response = await Supabase.instance.client
          .from('user_prefs')
          .select('value')
          .eq('user_id', userId)
          .eq('tag', tag)
          .maybeSingle(); // Use maybeSingle to handle no rows gracefully

      return response == null ? null : response['value'] as String;
    } catch (e) {
      throw Exception('Failed to fetch user preference: $e');
    }
  }

  // Fetch All Preferences for a User
  Future<List<UserPrefsModel>> fetchAllUserPrefs() async {
    try {
      final userId = auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in.');
      }

      final response = await prefsTable.select().eq('user_id', userId);

      return (response as List<dynamic>)
          .map((pref) => UserPrefsModel.fromMap(pref))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch all user preferences: $e');
    }
  }
}
