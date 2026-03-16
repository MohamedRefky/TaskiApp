import 'dart:convert';
import 'dart:io';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/model/task_model.dart';

class HiveStorageManager {
  HiveStorageManager._();
  static final HiveStorageManager _instance = HiveStorageManager._();
  factory HiveStorageManager() => _instance;
  late final Directory appDocumentsDirectory;


  late Box<TaskModel> _taskBox;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(StorageKey.tasksNameCollection);
  }

  saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
  }

  List <TaskModel> lodeTask()  {
  return _taskBox.values.toList();
  }

  clear() async {
    await _taskBox.clear();
  
  }
}
