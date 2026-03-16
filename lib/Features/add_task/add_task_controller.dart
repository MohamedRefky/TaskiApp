import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/hive_storage_manager.dart';
import 'package:tasky/model/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      List<TaskModel> taskList =  HiveStorageManager().lodeTask();
      TaskModel model = TaskModel(
        id: taskList.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      taskList.add(model);
      await HiveStorageManager().saveTasks(taskList);
      Navigator.of(context).pop(true);
    }
    notifyListeners();
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
