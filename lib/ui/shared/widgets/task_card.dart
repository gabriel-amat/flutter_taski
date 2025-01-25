import 'package:flutter/material.dart';
import 'package:taski/core/theme/app_text.dart';
import 'package:taski/models/task_model.dart';

import '../../../controllers/task/task_controller.dart';
import '../../../core/locator.dart';

class TaskCard extends StatefulWidget {
  final TaskModel model;

  const TaskCard({super.key, required this.model});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
            subtitle: widget.model.content.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child:
                        Text(widget.model.content, style: AppText.normal),
                  )
                : SizedBox.shrink(),
            controlAffinity: ListTileControlAffinity.leading,
            secondary: PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "delete",
                  child: Text("Excluir"),
                  onTap: () {
                    taskController.deleteTask(id: widget.model.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
