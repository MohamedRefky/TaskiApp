import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTask = [];
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

    final taskJson = PrefrancesManeger().getString('tasks');
    final List<dynamic> decoded = jsonDecode(taskJson!);
    setState(() {
      highPriorityTask = decoded.map((e) => TaskModel.fromjeson(e)).toList();
      highPriorityTask = highPriorityTask
          .where((element) => element.isHighPriority)
          .toList()
          .reversed
          .toList();

      isLoading = false;
    });
  }

_deleteTask(int? id) async {
  if (id == null) return;
  final taskJson = PrefrancesManeger().getString('tasks');
  if (taskJson != null) {
    final List<TaskModel> allTasks = (jsonDecode(taskJson) as List)
        .map((e) => TaskModel.fromjeson(e))
        .toList();
    allTasks.removeWhere((element) => element.id == id);
    setState(() {
      highPriorityTask.removeWhere((element) => element.id == id);
    });
    final updateTask = allTasks.map((e) => e.toMap()).toList();
    await PrefrancesManeger().setString('tasks', jsonEncode(updateTask));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
            : TaskListWidget(
                tasks: highPriorityTask,
                onTap: (bool? value, int? index) async {
                  if (index == null) return;

                  setState(() {
                    highPriorityTask[index].isDone = value ?? false;
                  });

                  final allData = PrefrancesManeger().getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((e) => TaskModel.fromjeson(e))
                        .toList();

                    final newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTask[index].id,
                    );
                    allDataList[newIndex] = highPriorityTask[index];

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
      ),
    );
  }
}
