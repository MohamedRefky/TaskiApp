import 'package:flutter/material.dart';
import 'package:tasky/Core/Theme/themes_controller.dart';
import 'package:tasky/Core/Widgets/custom_checkbox.dart';
import 'package:tasky/Core/Widgets/custom_svg_picture.dart';
import 'package:tasky/Screens/high_priority_screen.dart';
import 'package:tasky/Screens/home_screen.dart';
import 'package:tasky/model/task_model.dart';

class HighPriorityTasks extends StatefulWidget {
  const HighPriorityTasks({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  State<HighPriorityTasks> createState() => _HighPriorityTasksState();
}

class _HighPriorityTasksState extends State<HighPriorityTasks> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "High Priority Tasks",
                      style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.where((e) => e.isHighPriority).length > 4
                    ? 4
                    : tasks.where((e) => e.isHighPriority).length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks
                      .where((e) => e.isHighPriority)
                      .toList()[index];
                  return Row(
                    children: [
                      CustomCheckbox(
                        value: task.isDone,
                        onChanged: (bool? value) {
                          final index = widget.tasks.indexWhere(
                            (e) => e.id == task.id,
                          );
                          widget.onTap(value, index);
                        },
                      ),
                      Expanded(
                        child: Text(
                          task.taskName,
                          style: task.isDone
                              ? TextTheme.of(context).titleLarge
                              : TextTheme.of(context).titleMedium,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          bottom: 12,
          child: GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HighPriorityScreen(),
                ),
              );
              widget.refresh();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: ThemesController.isDark()
                      ? Color(0xFF6E6E6E)
                      : Color(0xFFD1DAD6),
                ),
              ),

              child: Center(
                child: CustomSvgPicture(
                  path: "assets/images/arrow-up-right.svg",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
