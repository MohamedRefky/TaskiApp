import 'package:flutter/material.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({
    super.key,
    required this.doneTask,
    required this.totalTask,
    required this.persent,
  });

  final int doneTask;
  final int totalTask;
  final double persent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: TextTheme.of(context).titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                "$doneTask Out of $totalTask Done",
                style: TextTheme.of(context).titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -3.14 / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: persent,
                    strokeWidth: 4,
                    backgroundColor: Color(0xFF6D6D6D),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF15B86C)),
                  ),
                ),
              ),
              Text(
                "${(persent * 100).toInt()}%",
                style: TextTheme.of(context).titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
