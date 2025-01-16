import 'package:flutter/material.dart';
import 'package:homepage/user_prefs/models/user_prefs_model.dart';
import 'package:homepage/user_prefs/services/user_prefs_service.dart';

class UserPrefsProvider extends ChangeNotifier {
  final UserPrefsService _userPrefsService = UserPrefsService();

  String username = 'Guest';
  String backgroundQuery = 'nature';
  bool autoHideBottomBar = false;

  bool isLoading = true; // Indicates if preferences are loading

  // Initialize preferences
  Future<void> loadUserPrefs() async {
    try {
      isLoading = true;
      notifyListeners();

      final fetchedUsername = await _userPrefsService.fetchUserPref(TAG_USERNAME);
      final fetchedBgQuery = await _userPrefsService.fetchUserPref(TAG_BACKGROUND_IMAGE_QUERY);
      final fetchedAutoHide = await _userPrefsService.fetchUserPref(TAG_HIDE_BOTTOM_FLOATING_BAR);

      username = fetchedUsername ?? 'Guest';
      backgroundQuery = fetchedBgQuery ?? 'nature';
      autoHideBottomBar = (fetchedAutoHide == 'true');
    } catch (e) {
      debugPrint('Error loading user preferences: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Update username
  Future<void> updateUsername(String newUsername) async {
    try {
      username = newUsername;
      notifyListeners();

      await _userPrefsService.upsertUserPref(
        tag: TAG_USERNAME,
        value: newUsername,
      );
    } catch (e) {
      debugPrint('Error updating username: $e');
    }
  }

  // Update background query
  Future<void> updateBackgroundQuery(String newQuery) async {
    try {
      backgroundQuery = newQuery;
      notifyListeners();

      await _userPrefsService.upsertUserPref(
        tag: TAG_BACKGROUND_IMAGE_QUERY,
        value: newQuery,
      );
    } catch (e) {
      debugPrint('Error updating background query: $e');
    }
  }

  // Update auto-hide bottom bar preference
  Future<void> updateAutoHideBottomBar(bool newValue) async {
    try {
      autoHideBottomBar = newValue;
      notifyListeners();

      await _userPrefsService.upsertUserPref(
        tag: TAG_HIDE_BOTTOM_FLOATING_BAR,
        value: newValue ? 'true' : 'false',
      );
    } catch (e) {
      debugPrint('Error updating auto-hide bottom bar preference: $e');
    }
  }
}