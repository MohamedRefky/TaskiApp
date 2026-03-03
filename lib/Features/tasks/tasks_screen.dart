import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Core/componant/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final taskJson = PrefrancesManeger().getString('tasks') ?? '[]';

    final List<dynamic> decoded = jsonDecode(taskJson);
    setState(() {
      tasks = decoded.map((e) => TaskModel.fromjeson(e)).toList();
      tasks = tasks.where((element) => element.isDone == false).toList();

      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    if (id == null) return;

    final taskJson = PrefrancesManeger().getString('tasks') ?? '[]';
    final allTasks = (jsonDecode(taskJson) as List)
        .map((e) => TaskModel.fromjeson(e))
        .toList();

    setState(() {
      tasks.removeWhere((t) => t.id == id);
    });
    final updatedTasks = allTasks.where((t) => t.id != id).toList();
    await PrefrancesManeger().setString(
      'tasks',
      jsonEncode(updatedTasks.map((e) => e.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks")),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
          : TaskListWidget(

              tasks: tasks,
              onTap: (bool? value, int? index) async {
                if (index == null) return;
                setState(() {
                  tasks[index].isDone = value ?? false;
                });
                final allData = PrefrancesManeger().getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromjeson(e))
                      .toList();

                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == tasks[index].id,
                  );
                  allDataList[newIndex] = tasks[index];
                  PrefrancesManeger().setString(
                    'tasks',
                    jsonEncode(allDataList.map((e) => e.toMap()).toList()),
                  );
                  _loadTasks();
                }
              },
              emptyMessage: 'No Tasks Found',
              onDelete: (int? id) {
                _deleteTask(id);
              },
              onEdit: () {
                _loadTasks();
              },
            ),
    );
  }
}
