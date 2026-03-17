import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Core/componant/task_list_widget.dart';
import 'package:tasky/Features/tasks/controller/tasks_controller.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
          : Consumer<TasksController>(
              builder: (BuildContext context, valueController, Widget? child) {
                return TaskListWidget(
                  tasks: valueController.completeTasks,
                  onTap: (bool? value, int? index) async {
                    controller.doneTask(value, valueController.completeTasks[index!].id);

                    controller.init();
                  },
                  emptyMessage: 'No Tasks Found',
                  onDelete: (int? id) {
                    controller.deleteTask(id);
                  },
                  onEdit: () {
                    controller.init();
                  },
                );
              },
            ),
    );
  }
}
