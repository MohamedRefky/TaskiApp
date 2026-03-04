import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Features/add_task/add_task_screen.dart';
import 'package:tasky/Features/home/componant/achieved_tasks_widget.dart';
import 'package:tasky/Features/home/componant/high_priority_tasks_widget.dart';
import 'package:tasky/Features/home/componant/sliver_task_list_widget.dart';
import 'package:tasky/Features/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer(
        builder: (context, HomeController value, child) {
          final controller = context.read<HomeController>();
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
                                backgroundImage: value.userImagePath == null
                                    ? AssetImage('assets/images/person.png')
                                    : FileImage(File(value.userImagePath!)),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Good Evening ${value.name} ',
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
                                  SvgPicture.asset(
                                    'assets/images/waving-hand.svg',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          AchievedTasks(
                            doneTask: value.totalDoneTask,
                            totalTask: value.totalTask,
                            persent: value.persent,
                          ),
                          SizedBox(height: 8),
                          HighPriorityTasks(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) async {
                              if (index == null) return;
                              controller.doneTask(value, index);

                              controller.tasks[index].isDone = value!;
                            },
                            refresh: () {
                              controller.loadTask();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              "My Tasks ",
                              style: TextTheme.of(context).labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    value.isLoading
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFFFCFC),
                              ),
                            ),
                          )
                        : SliverTaskListWidget(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) async {
                              if (index == null) return;
                              controller.doneTask(value, index);
                              controller.loadTask();
                            },
                            emptyMessage: 'No Data',
                            onDelete: (int? id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () {
                              controller.loadTask();
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
                    controller.loadTask();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
