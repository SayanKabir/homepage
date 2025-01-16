import 'package:supabase_flutter/supabase_flutter.dart';

class TaskModel {
  final String id;
  final String userId;
  final String taskText;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.userId,
    required this.taskText,
    required this.isCompleted,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      userId: map['user_id'],
      taskText: map['task_text'] as String,
      isCompleted: map['is_completed'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    final userID = Supabase.instance.client.auth.currentUser?.id;
    return {
      'id': id,
      'user_id': userID,
      'task_text': taskText,
      'is_completed': isCompleted,
    };
  }
}