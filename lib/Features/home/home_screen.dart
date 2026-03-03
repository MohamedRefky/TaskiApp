import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Features/add_task/add_task_screen.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Features/home/componant/achieved_tasks_widget.dart';
import 'package:tasky/Features/home/componant/high_priority_tasks_widget.dart';
import 'package:tasky/Features/home/componant/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? name;
List<TaskModel> tasks = [];
bool isLoading = false;
int totalTask = 0;
int totalDoneTask = 0;
double persent = 0;
String? userImagePath;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _lodeUserName();
    _loadTasks();
    super.initState();
  }

  void _lodeUserName() async {
    setState(() {
      name = PrefrancesManeger().getString('username');
      userImagePath = PrefrancesManeger().getString('user_image');
    });
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final taskJson = PrefrancesManeger().getString('tasks') ?? '[]';
    final List<dynamic> decoded = jsonDecode(taskJson);

    setState(() {
      tasks = decoded.map((e) => TaskModel.fromjeson(e)).toList();
      _calculatePesent();
    });
    setState(() {
      isLoading = false;
    });
  }

  _calculatePesent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((element) => element.isDone).length;
    persent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      totalTask = tasks.length;
      totalDoneTask = tasks.where((e) => e.isDone).length;
      persent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
      _calculatePesent();
    });

    final updateTask = tasks.map((e) => e.toMap()).toList();
    await PrefrancesManeger().setString('tasks', jsonEncode(updateTask));
  }

  _deleteTask(int? id) async {
    if (id == null) return;

    final taskJson = PrefrancesManeger().getString('tasks') ?? '[]';
    final allTasks = (jsonDecode(taskJson) as List)
        .map((e) => TaskModel.fromjeson(e))
        .toList();

    final updatedTasks = allTasks.where((t) => t.id != id).toList();

    setState(() {
      tasks.removeWhere((t) => t.id == id);
      _calculatePesent();
    });

    await PrefrancesManeger().setString(
      'tasks',
      jsonEncode(updatedTasks.map((e) => e.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: userImagePath == null
                              ? AssetImage('assets/images/person.png')
                              : FileImage(File(userImagePath!)),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Evening $name ',
                              style: TextTheme.of(context).titleMedium,
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: TextTheme.of(context).titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Yuhuu ,Your work Is Done',
                          style: TextTheme.of(context).displayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              'almost done !',
                              style: TextTheme.of(context).displayLarge,
                            ),
                            SvgPicture.asset('assets/images/waving-hand.svg'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AchievedTasks(
                      doneTask: totalDoneTask,
                      totalTask: totalTask,
                      persent: persent,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasks(
                      tasks: tasks,
                      onTap: (bool? value, int? index) async {
                        if (index == null) return;
                        _doneTask(value, index);
                        setState(() {
                          tasks[index].isDone = value!;
                        });
                      },
                      refresh: () {
                        _loadTasks();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                      child: Text(
                        "My Tasks ",
                        style: TextTheme.of(context).labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                    )
                  : SliverTaskListWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) async {
                        if (index == null) return;
                        _doneTask(value, index);
                        _loadTasks();
                      },
                      emptyMessage: 'No Data',
                      onDelete: (int? id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadTasks();
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
            if (result != null && result) {
              _loadTasks();
            }
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
