import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskState();
}

List<TaskModel> task = [];

class _AddTaskState extends State<AddTaskScreen> {
  @override
  void initState() {
    super.initState();
    _lodeTask();
  }

  void _lodeTask() async {
    final finalTask = PrefrancesManeger().getString(StorageKey.tasks) ?? '[]';
    final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
    setState(() {
      task = taskAfterDecode
          .map((element) => TaskModel.fromjeson(element))
          .toList();
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormfield(
                title: "Task Name",
                controller: taskNameController,
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
                controller: taskDescriptionController,
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
                  Switch(
                    value: isHighPriority,
                    onChanged: (bool value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
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
                  if (_key.currentState?.validate() ?? false) {
                    final taskJson = PrefrancesManeger().getString(StorageKey.tasks);
                    List<dynamic> taskList = [];
                    if (taskJson != null) {
                      taskList = jsonDecode(taskJson);
                    }
                    TaskModel model = TaskModel(
                      id: taskList.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    taskList.add(model.toMap());
                    await PrefrancesManeger().setString(
                     StorageKey.tasks,
                      jsonEncode(taskList),
                    );
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
