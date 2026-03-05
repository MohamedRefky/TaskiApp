import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/model/task_model.dart';

class HomeController with ChangeNotifier {
  String? userName;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTask = 0;
  double persent = 0;
  String? userImagePath;


init(){
  loadTask();
  loadUserData();
}
  void loadUserData() async {
    userName = PrefrancesManeger().getString(StorageKey.username);
    userImagePath = PrefrancesManeger().getString(StorageKey.userImage);

    notifyListeners();
  }

  void loadTask() async {
    isLoading = true;

    final finalTask = PrefrancesManeger().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode.map((element) => TaskModel.fromjeson(element)).toList();
      calculatePesent();
    }

    isLoading = false;

    notifyListeners();
  }

  calculatePesent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((element) => element.isDone).length;
    persent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  doneTask(bool? value, int? index) async {
   
      tasks[index!].isDone = value ?? false;
      totalTask = tasks.length;
      totalDoneTask = tasks.where((e) => e.isDone).length;
      persent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
      calculatePesent();


    final updateTask = tasks.map((e) => e.toMap()).toList();
    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(updateTask),
    );
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    final taskJson = PrefrancesManeger().getString(StorageKey.tasks) ?? '[]';
    final allTasks = (jsonDecode(taskJson) as List)
        .map((e) => TaskModel.fromjeson(e))
        .toList();

    final updatedTasks = allTasks.where((t) => t.id != id).toList();

  
      tasks.removeWhere((t) => t.id == id);
      calculatePesent();
   

    await PrefrancesManeger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTasks.map((e) => e.toMap()).toList()),
    );
    notifyListeners();
  }

}
