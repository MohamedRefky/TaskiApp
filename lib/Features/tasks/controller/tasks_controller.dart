import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/model/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTask = [];

  init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PrefrancesManeger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromjeson(element))
          .toList();
      todoTasks = tasks.where((element) => !element.isDone).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();

      highPriorityTask = tasks
          .where((element) => element.isHighPriority)
          .toList()
          .reversed
          .toList();
    }

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null || index >= todoTasks.length) return;

    TaskModel task = todoTasks[index];
    task.isDone = value ?? false;
    final int mainIndex = tasks.indexWhere((e) => e.id == task.id);
    if (mainIndex != -1) tasks[mainIndex] = task;
    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completeTasks = tasks.where((e) => e.isDone).toList();

    notifyListeners();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null || index >= completeTasks.length) return;

    TaskModel task = completeTasks[index];
    task.isDone = value ?? false;

    final int mainIndex = tasks.indexWhere((e) => e.id == task.id);
    if (mainIndex != -1) tasks[mainIndex] = task;

    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );

    todoTasks = tasks.where((e) => !e.isDone).toList();
    completeTasks = tasks.where((e) => e.isDone).toList();

    notifyListeners();
  }
  void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;

    TaskModel task = highPriorityTask[index];
    task.isDone = value ?? false;

    final int mainIndex = tasks.indexWhere((e) => e.id == task.id);
    if (mainIndex != -1) tasks[mainIndex] = task;

    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );

    todoTasks = tasks.where((e) => !e.isDone).toList();
    highPriorityTask = tasks.where((e) => e.isDone).toList();

    notifyListeners();
  }
  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((tasks) => tasks.id == id);
    completeTasks.removeWhere((tasks) => tasks.id == id);
    highPriorityTask.removeWhere((tasks) => tasks.id == id);

    final updatedTask = tasks.map((e) => e.toMap()).toList();
    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }
}
