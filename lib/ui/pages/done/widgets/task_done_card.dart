import 'package:flutter/material.dart';
import 'package:taski/models/task_model.dart';

import '../../../../controllers/task/task_controller.dart';
import '../../../../core/locator.dart';
import '../../../../core/theme/app_text.dart';

class TaskDoneCard extends StatefulWidget {
  final TaskModel model;

  const TaskDoneCard({super.key, required this.model});

  @override
  State<TaskDoneCard> createState() => _TaskDoneCardState();
}

class _TaskDoneCardState extends State<TaskDoneCard> {
  final taskController = locator.get<TaskController>();
  bool isDone = false;

  @override
  void initState() {
    debugPrint("Done: ${widget.model.done}");
    isDone = widget.model.done;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CheckboxListTile.adaptive(
            value: isDone,
            onChanged: (value) {
              if (value == null) return;

              setState(() => isDone = value);
              taskController.updateTask(
                data: widget.model.copyWith(done: value),
              );
            },
            title: Text(widget.model.title, style: AppText.title),
            controlAffinity: ListTileControlAffinity.leading,
            secondary: IconButton(
              onPressed: () {
                taskController.deleteTask(id: widget.model.id);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
