import 'package:homepage/features/quick_tasks/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TasksService {
  final tasksTable = Supabase.instance.client.from('tasks');
  final auth = Supabase.instance.client.auth;

  // CREATE
  Future<void> addNewTask({required String taskText}) async {
    try {
      await tasksTable.insert({
        'user_id': auth.currentUser?.id,
        'task_text': taskText,
      });
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // READ STREAM
  final Stream<List<TaskModel>> stream = Supabase.instance.client
      .from('tasks')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: true) // Sort by created_at in ascending order
      .map((data) => data.map((taskMap) => TaskModel.fromMap(taskMap)).toList());

  // UPDATE
  Future<void> updateTask({
    required String id,
    required String taskText,
    required bool isCompleted,
  }) async {
    try {
      await tasksTable.update({
        'task_text': taskText,
        'is_completed': isCompleted,
      }).eq('id', id);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // DELETE
  Future<void> deleteTask(TaskModel task) async {
    try {
      await tasksTable.delete().eq('id', task.id);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}