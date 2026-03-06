import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/model/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
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

      taskList.add(model.toJson());
      await PrefrancesManeger().setString(
        StorageKey.tasks,
        jsonEncode(taskList),
      );
      Navigator.of(context).pop(true);
    }
    notifyListeners();
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
