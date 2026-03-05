import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Features/add_task/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('Add New Task')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Form(
              key: controller.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormfield(
                    title: "Task Name",
                    controller: controller.taskNameController,
                    hintText: "Finish UI design for login screen",
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Task Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormfield(
                    title: "Task Description",
                    maxLines: 5,
                    controller: controller.taskDescriptionController,
                    hintText:
                        "Finish onboarding UI and hand off to devs by Thursday.",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consumer<AddTaskController>(
                        builder: (context, value, child) => Switch(
                          value: value.isHighPriority,
                          onChanged: (bool value) {
                            controller.toggle(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    label: Text('Add Task'),
                    icon: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      context.read<AddTaskController>().addTask(context);
                    },
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
