import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';
import 'package:homepage/features/quick_note/models/note_model.dart';
import 'package:homepage/features/quick_note/services/note_service.dart';

class NotesIsland extends StatefulWidget {
  const NotesIsland({super.key});

  @override
  State<NotesIsland> createState() => _NotesIslandState();
}

class _NotesIslandState extends State<NotesIsland> {
  final noteService = NoteService();
  final noteController = TextEditingController();
  bool saved = true;

  void getNote() async {
    Note note = await noteService.fetchNote();
    noteController.text = note.note_text;
  }
  void upsertNote() async {
    await noteService.upsertNote(noteController.text);
  }

  @override
  void initState() {
    super.initState();
    getNote();
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, isHovered) {
        return AnimatedScale(
          scale: isHovered ? 1.05 : 1,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
          child: Blur(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // height: 250,
              // width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withValues(alpha: 0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Quick Note',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              upsertNote();
                              saved = true;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withValues(alpha: 0.1),
                            ),
                            child: Blur(
                              child: FaIcon(
                                saved ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circleUp,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,

                      ),
                      maxLines: 100,
                      // keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      cursorColor: Colors.white,
                      controller: noteController,
                      onChanged: (value){
                        setState(() {
                          saved = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}