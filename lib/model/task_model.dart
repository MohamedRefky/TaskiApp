class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;
  final int ? id ;
  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
     this.isDone = false,
  });
  factory TaskModel.fromjeson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? 0,
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }
}
