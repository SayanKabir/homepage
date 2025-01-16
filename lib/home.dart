import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/bottom_floating_bar.dart';
import 'package:homepage/features/background/views/background_image.dart';
import 'package:homepage/features/clock/views/clock_digital.dart';
import 'package:homepage/components/hover_button.dart';
import 'package:homepage/features/greetings/views/greetings.dart';
import 'package:homepage/features/pinned_tabs/views/pinned_tabs.dart';
import 'package:homepage/features/quick_note/views/quick_note.dart';
import 'package:homepage/features/quick_tasks/views/quick_tasks.dart';
import 'package:homepage/features/settings/views/settings.dart';
import 'package:homepage/user_prefs/providers/user_prefs_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSettings = false;
  bool showNotes = false;
  bool showTasks = false;
  final GlobalKey<BackgroundWidgetState> backgroundKey = GlobalKey<BackgroundWidgetState>();

  void toggleSettingsTab() {
    setState(() {
      showSettings = !showSettings;
    });
  }

  void toggleNotesTab() {
    setState(() {
      showNotes = !showNotes;
    });
  }

  void toggleTasksTab() {
    setState(() {
      showTasks = !showTasks;
    });
  }

  void refreshBackground() {
    backgroundKey.currentState?.refreshImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // BACKGROUND
          BackgroundWidget(key: backgroundKey),

          // PINNED TABS
          Align(alignment: Alignment.topLeft, child: PinnedTabs()),

          // CLOCK AND GREETING
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DigitalClock(containerOpacity: 0, size: 3, position: 0),
                Greeting(size: 1.5),
                AnimatedContainer(
                  height: showNotes ? 250 : 0,
                  width: showNotes ? 500 : 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc,
                  child: NotesIsland(),
                ),
              ],
            ),
          ),

          // SETTINGS, TASKS, NOTES BUTTONS BOTTOM FLOATING BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomFloatingBar(
              autoHideBottomBar: context.read<UserPrefsProvider>().autoHideBottomBar,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  HoverButton(iconData: FontAwesomeIcons.gear, onPressed: toggleSettingsTab),
                  HoverButton(iconData: FontAwesomeIcons.noteSticky, onPressed: toggleNotesTab),
                  HoverButton(iconData: FontAwesomeIcons.listCheck, onPressed: toggleTasksTab),
                  HoverButton(iconData: FontAwesomeIcons.mountainSun, onPressed: refreshBackground),
                ],
              ),
            ),
          ),

          // SETTINGS ISLAND
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCirc,
              height: showSettings ? 400 : 0,
              width: showSettings ? 250 : 0,
              child: SettingsIsland(),
            ),
          ),

          // TASKS ISLAND
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCirc,
              width: showTasks ? 250 : 0,
              height: showTasks ? 400 : 0,
              child: TasksIsland(),
            ),
          ),
        ],
      ),
    );
  }
}
