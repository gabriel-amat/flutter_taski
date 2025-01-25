import 'package:taski/models/task_model.dart';

abstract interface class TaskState {}

class ErrorTask extends TaskState {
  final String msg;

  ErrorTask({required this.msg});
}

class LoadingTask extends TaskState {}

class EmptyTask extends TaskState {}

class LoadedTask extends TaskState {
  final List<TaskModel> list;

  LoadedTask({required this.list});
}
