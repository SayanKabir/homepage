import 'package:homepage/features/quick_note/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteService {
  final notesTable = Supabase.instance.client.from('note');
  final auth = Supabase.instance.client.auth;

  //CREATE
  Future createNote(String noteText) async {
    await notesTable.insert({'note_text': noteText});
  }

  //READ STREAM
  final stream = Supabase.instance.client.from('notes').stream(primaryKey: ['id'])
      .map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());

  //READ SINGLE
  Future fetchNote() async {
    final Map<String, dynamic> note = await notesTable.select().single();

    return Note.fromMap(note);
  }

  //UPSERT NOTE
  Future upsertNote(String noteText) async {
    final response = await notesTable.upsert({
      'user_id': auth.currentUser?.id,
      'note_text': noteText,
    });
    return response;
  }
}