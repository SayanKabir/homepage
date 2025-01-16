import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';
import 'package:homepage/components/simple_button.dart';
import 'package:homepage/features/quick_tasks/widgets/task_item.dart';
import 'package:homepage/features/quick_tasks/models/task_model.dart';
import 'package:homepage/features/quick_tasks/services/tasks_service.dart';

class TasksIsland extends StatefulWidget {
  const TasksIsland({super.key});

  @override
  State<TasksIsland> createState() => _TasksIslandState();
}

class _TasksIslandState extends State<TasksIsland> {
  final taskController = TextEditingController();
  final tasksService = TasksService();

  // Add a new task
  Future<void> addNewTask() async {
    if (taskController.text.isNotEmpty) {
      await tasksService.addNewTask(taskText: taskController.text);
      taskController.clear(); // Clear the text field after adding a task
    }
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, isHovered) {
        return AnimatedScale(
          scale: isHovered ? 1.05 : 1,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Blur(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Tasks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tasks List
                    Expanded(
                      child: StreamBuilder<List<TaskModel>>(
                        stream: tasksService.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SpinKitPulse(
                                color: Colors.black.withValues(alpha: 0.7),
                                size: 100,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'No tasks available. Add a task to get started!',
                                  style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7)),
                                ),
                              ),
                            );
                          }

                          final tasks = snapshot.data!;
                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskItem(taskItem: task);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Add Task Button
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            decoration: InputDecoration(
                              hintText: 'Enter a new task',
                              hintStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7)),
                              filled: true,
                              fillColor: Colors.black.withValues(alpha: 0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                            ),
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        MyTextButton(
                          onPressed: addNewTask,
                          child: Text(
                            'Add',
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
