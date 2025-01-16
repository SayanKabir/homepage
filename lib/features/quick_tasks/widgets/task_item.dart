import 'package:flutter/material.dart';
import 'package:homepage/features/quick_tasks/models/task_model.dart';
import 'package:homepage/features/quick_tasks/services/tasks_service.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskItem;

  const TaskItem({super.key, required this.taskItem});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isCompleted;
  final TasksService tasksService = TasksService();

  @override
  void initState() {
    super.initState();
    isCompleted = widget.taskItem.isCompleted; // Initialize completion state
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> toggleTaskCompletion(bool value) async {
    try {
      await tasksService.updateTask(
        id: widget.taskItem.id,
        taskText: widget.taskItem.taskText,
        isCompleted: value,
      );
      setState(() {
        isCompleted = value;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.black.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: 100,
            child: Text(
              widget.taskItem.taskText,
              style: TextStyle(
                color: isCompleted ? Colors.white.withValues(alpha: 0.5) : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: MSHCheckbox(
              value: isCompleted,
              onChanged: toggleTaskCompletion,
              size: 22,
              duration: const Duration(milliseconds: 200),
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Colors.green,
                uncheckedColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}