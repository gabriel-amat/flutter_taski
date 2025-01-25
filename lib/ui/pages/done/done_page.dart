import 'package:flutter/material.dart';
import 'package:taski/controllers/task/task_controller.dart';
import 'package:taski/core/theme/app_text.dart';
import 'package:taski/ui/pages/done/widgets/task_done_card.dart';
import 'package:taski/ui/shared/widgets/empty_list.dart';

import '../../../controllers/task/task_state.dart';
import '../../../core/locator.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final taskController = locator.get<TaskController>();
  void showDeleteAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Certeza que deseja excluir tudo?"),
        actions: [
          TextButton(
            onPressed: () {
              taskController.deleteAll();
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text("Sim, excluir"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Completed Task", style: AppText.title),
              TextButton(
                onPressed: showDeleteAlert,
                child: Text(
                  "Delete all",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder<TaskState>(
              valueListenable: taskController.tasks,
              builder: (context, value, widget) {
                if (value is LoadingTask && value is! ErrorTask) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (value is EmptyTask) {
                  return EmptyList(label: "You have no task listed");
                }

                if (value is LoadedTask) {
                  final list = value.list.where((e) => e.done).toList();

                  if (list.isEmpty) {
                    return EmptyList(label: "No tasks completed yet.");
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return TaskDoneCard(model: list[index]);
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
