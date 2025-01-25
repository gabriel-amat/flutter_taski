import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski/models/task_model.dart';

class TaskLocalService {
  late Box<TaskModel> box;

  Future<void> _openBox() async {
    box = await Hive.openBox<TaskModel>(TaskModel.boxKey);
  }

  Future<List<TaskModel>> get() async {
    debugPrint("Get tasks");
    await _openBox();
    return box.values.toList();
  }

  Future<void> add({required TaskModel data}) async {
    debugPrint('Add Task');
    _openBox();
    if (!box.containsKey(data.id)) {
      await box.put(data.id, data);
    }
  }

  Future<void> updateTask({required TaskModel data}) async {
    debugPrint("UpdateTask ${data.id}");
    if (box.containsKey(data.id)) {
      await box.put(data.id, data);
    }
  }

  Future<void> deleteBox() async {
    debugPrint('Delete all Task');
    if (box.isOpen) {
      await box.clear();
    } else {
      debugPrint("Box not open");
    }
  }

  Future<void> remove({required String id}) async {
    debugPrint("Delete Task");
    await _openBox();
    await box.delete(id);
  }
}
