import 'package:flutter/material.dart';
import 'package:taski/models/task_model.dart';

import '../../core/locator.dart';
import '../../repositories/local/task_local_service.dart';
import '../../ui/shared/custom_snack.dart';
import 'task_state.dart';

class TaskController {
  TaskController({required this.localService});

  TaskLocalService localService;
  CustomSnack get snack => locator.get<CustomSnack>();

  final tasks = ValueNotifier<TaskState>(LoadingTask());

  //Functions----------------------
  Future<void> getTasks() async {
    tasks.value = LoadingTask();

    final res = await localService.get();
    debugPrint("Tasks: ${res.length}");
    if (res.isEmpty) {
      tasks.value = EmptyTask();
      return;
    }

    tasks.value = LoadedTask(list: res);
  }

  Future<void> addTask({required TaskModel data}) async {
    await localService.add(data: data);
    getTasks();
  }

  Future<void> deleteTask({required String id}) async {
    await localService.remove(id: id);
    getTasks();
  }

  Future<void> deleteAll() async {
    await localService.deleteBox();
    getTasks();
  }

  Future<void> updateTask({required TaskModel data}) async {
    await localService.updateTask(data: data);
    getTasks();
  }

  Future<List<TaskModel>> searchTodos({required String query}) async {
    final list = await localService.get();

    if (list.isEmpty) return [];

    return list.where(
      (todo) {
        return todo.title.toLowerCase().contains(query.toLowerCase());
      },
    ).toList();
  }
}
