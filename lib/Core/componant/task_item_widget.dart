import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Theme/themes_controller.dart';
import 'package:tasky/Core/Widgets/custom_checkbox.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/Core/enums/task_item_action_enums.dart';
import 'package:tasky/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function() onEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemesController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          CustomCheckbox(value: model.isDone, onChanged: onChanged),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.taskName,
                style: TextStyle(
                  color: model.isDone
                      ? TextTheme.of(context).titleLarge!.color
                      : TextTheme.of(context).titleMedium!.color,
                  fontSize: 20,
                  decoration: model.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Color(0xFFA0A0A0),
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              if (model.taskDescription.isNotEmpty)
                Text(
                  model.taskDescription,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                ),
            ],
          ),
          Spacer(),
          PopupMenuButton<TaskItemActionEnums>(
            icon: Icon(
              Icons.more_vert,
              color: ThemesController.isDark()
                  ? (model.isDone ? Color(0xFFA0A0A0) : Color(0xFFC6C6C6))
                  : (model.isDone ? Color(0xFF6A6A6A) : Color(0xFF3A4640)),
              size: 30,
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionEnums.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionEnums.delete:
                  await _showAlertDialog(context);
                case TaskItemActionEnums.edit:
                  final resalt = await _showButtomShet(context, model);
                  if (resalt == true) {
                    onEdit();
                  }
              }
            },
            itemBuilder: (context) => TaskItemActionEnums.values
                .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              onDelete(model.id);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showButtomShet(context, TaskModel model) {
    bool isHighPriority = model.isHighPriority;
    final key = GlobalKey<FormState>();
    final taskNameController = TextEditingController(text: model.taskName);
    final taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    return showModalBottomSheet(
      // isDismissible: false,
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Form(
              key: key,
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
                    label: Text('ُEdit Task'),
                    icon: Icon(Icons.edit),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (key.currentState?.validate() ?? false) {
                        final taskJson = PrefrancesManeger().getString(
                          StorageKey.tasks,
                        );
                        List<dynamic> taskList = [];
                        if (taskJson != null) {
                          taskList = jsonDecode(taskJson);
                        }
                        TaskModel newModel = TaskModel(
                          id: model.id,
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                          isDone: model.isDone,
                        );

                        taskList
                            .firstWhere((e) => e['id'] == model.id)
                            .updateAll((key, value) => newModel.toJson()[key]);
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
          );
        },
      ),
    );
  }
}
