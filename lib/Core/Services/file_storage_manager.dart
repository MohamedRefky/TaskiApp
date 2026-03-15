import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  FileStorageManager._();
  static final FileStorageManager _instance = FileStorageManager._();
  factory FileStorageManager() => _instance;
  late final Directory appDocumentsDirectory;
  late final File _tasksFile;

  init() async {
    appDocumentsDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File('${appDocumentsDirectory.path}/tasks.json');
  }

  saveTasks(List<dynamic> list) async {
    final listJeson = jsonEncode(list);
    await _tasksFile.writeAsString(listJeson);
  }

  Future<List<dynamic>> lodeTask() async {
    if (!await _tasksFile.exists()) return [];
    final taskJeson = await _tasksFile.readAsString();
    return jsonDecode(taskJeson) as List<dynamic>;
  }

  clear() async {
    if (!await _tasksFile.exists()) return;
    await _tasksFile.delete();
  }
}
