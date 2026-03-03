enum TaskItemActionEnums {
  markAsDone(name: "Mark as Done"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;
  const TaskItemActionEnums({required this.name});
}
