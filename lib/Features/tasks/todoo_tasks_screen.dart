import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Core/componant/task_list_widget.dart';
import 'package:tasky/Features/tasks/controller/tasks_controller.dart';

class TodoTasks extends StatelessWidget {
  const TodoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Scaffold(
          appBar: AppBar(title: Text("To Do Tasks")),
          body: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFFCFC)),
                )
              : Consumer<TasksController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return TaskListWidget(
                      tasks: value.todoTasks,
                      onTap: (value, index) async {
                        controller.doneTask(value, index);
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
      },
    );
  }
}
