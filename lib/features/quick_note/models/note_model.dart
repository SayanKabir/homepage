
class Note {
  String note_text;
  Note({required this.note_text});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      note_text: map['note_text'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'note_text' : note_text,};
  }
}