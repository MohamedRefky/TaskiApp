import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Features/home/home_screen.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Core/componant/task_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> tasks = [];
  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final taskJson = PrefrancesManeger().getString('tasks');
    final List<dynamic> decoded = jsonDecode(taskJson ?? '[]');
    setState(() {
      tasks = decoded.map((e) => TaskModel.fromjeson(e)).toList();
      tasks = tasks.where((element) => element.isDone).toList();

      isLoading = false;
    });
  }

  // _deleteTask(int? id) async {

  //   if (id == null) return;
  //   final taskJson = PrefrancesManeger().getString('tasks');
  //   if (taskJson != null) {
  //     final List<dynamic> decoded = jsonDecode(taskJson);
  //    tasks  = decoded.map((e) => TaskModel.fromjeson(e)).toList();
  //     tasks.removeWhere((element) => element.id == id);

  //     setState(() {
  //       tasks.removeWhere((element) => element.id == id);
  //     });
  //     final updateTask = tasks.map((e) => e.toMap()).toList();
  //     await PrefrancesManeger().setString('tasks', jsonEncode(updateTask));
  //   }
  // }

  _deleteTask(int? id) async {
    if (id == null) return;

    final taskJson = PrefrancesManeger().getString('tasks') ?? '[]';
    final allTasks = (jsonDecode(taskJson) as List)
        .map((e) => TaskModel.fromjeson(e))
        .toList();

    final updatedTasks = allTasks.where((t) => t.id != id).toList();

    setState(() {
      tasks.removeWhere((t) => t.id == id);
    });

    await PrefrancesManeger().setString(
      'tasks',
      jsonEncode(updatedTasks.map((e) => e.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
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
                  await PrefrancesManeger().setString(
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
