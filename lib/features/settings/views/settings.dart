import 'package:flutter/material.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/features/settings/widgets/settings_tile.dart';
import 'package:homepage/components/simple_button.dart';
import 'package:homepage/user_prefs/models/user_prefs_model.dart';
import 'package:homepage/auth/services/auth_service.dart';
import 'package:homepage/user_prefs/services/user_prefs_service.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class SettingsIsland extends StatefulWidget {
  const SettingsIsland({super.key});

  @override
  State<SettingsIsland> createState() => _SettingsIslandState();
}

class _SettingsIslandState extends State<SettingsIsland> {
  final usernameController = TextEditingController();
  final bgQueryController = TextEditingController();
  bool autoHide = false;
  final userPrefsService = UserPrefsService();
  bool bgQuerySaved = false;
  bool userNameSaved = false;

  Future<void> fetchAllPrefs() async {
    final backgroundQuery =
        await userPrefsService.fetchUserPref(TAG_BACKGROUND_IMAGE_QUERY);
    final username = await userPrefsService.fetchUserPref(TAG_USERNAME);
    final autohide =
        await userPrefsService.fetchUserPref(TAG_HIDE_BOTTOM_FLOATING_BAR);

    setState(() {
      bgQueryController.text =
          (backgroundQuery == null || backgroundQuery.isEmpty)
              ? 'nature'
              : backgroundQuery;
      usernameController.text =
          (username == null || username.isEmpty) ? '' : username;
      autoHide = (autohide == 'true') ? true : false;
    });
  }

  void logOutUser() async {
    final authService = AuthService();
    await authService.signOut();
  }

  Future<void> upsertUserName() async {
    await userPrefsService.upsertUserPref(
      tag: TAG_USERNAME,
      value: usernameController.text,
    );
  }

  Future<void> upsertBGQuery() async {
    await userPrefsService.upsertUserPref(
      tag: TAG_BACKGROUND_IMAGE_QUERY,
      value: bgQueryController.text,
    );
  }

  Future<void> upsertAutohide() async {
    await userPrefsService.upsertUserPref(
      tag: TAG_HIDE_BOTTOM_FLOATING_BAR,
      value: (autoHide == true) ? 'true' : 'false',
    );
  }

  @override
  void initState() {
    super.initState();

    fetchAllPrefs();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Blur(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withValues(alpha: 0.5),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                // TITLE
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const Text(
                  'Background image query',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
                SettingsTile(
                  controller: bgQueryController,
                  onSubmit: () async {
                    setState(() {
                      bgQuerySaved = true;
                    });
                    await upsertBGQuery();
                  },
                  saved: bgQuerySaved,
                ),

                const Text(
                  'Display name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
                SettingsTile(
                  controller: usernameController,
                  onSubmit: () async {
                    setState(() {
                      userNameSaved = true;
                    });
                    await upsertUserName();
                  },
                  saved: userNameSaved,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        child: Text(
                          'Auto-hide bottom floating bar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: MSHCheckbox(
                          value: autoHide,
                          onChanged: (value) async {
                            setState(() {
                              autoHide = value;
                            });
                            await upsertAutohide();
                          },
                          size: 22,
                          duration: const Duration(milliseconds: 200),
                          colorConfig:
                              MSHColorConfig.fromCheckedUncheckedDisabled(
                            checkedColor: Colors.green,
                            uncheckedColor: Colors.white,
                          ),
                          style: MSHCheckboxStyle.fillScaleCheck,
                        ),
                      ),
                    ],
                  ),
                ),
                MyTextButton(
                  onPressed: logOutUser,
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
