import 'package:flutter/material.dart';
import 'package:taski/controllers/task/task_state.dart';
import 'package:taski/core/theme/app_text.dart';
import 'package:taski/ui/shared/widgets/task_card.dart';

import '../../../controllers/task/task_controller.dart';
import '../../../core/locator.dart';
import '../../shared/widgets/empty_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = locator.get<TaskController>();

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Welcome, ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'Gabriel Amat.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          ValueListenableBuilder<TaskState>(
            valueListenable: taskController.tasks,
            builder: (context, value, widget) {
              if (value is LoadedTask) {
                final list = value.list.where((e) => e.done == false).toList();
                return Text(
                  "You`ve got ${list.length} to do",
                  style: AppText.normal,
                );
              }
              return SizedBox.shrink();
            },
          ),
          SizedBox(height: 24),
          Expanded(
            child: ValueListenableBuilder<TaskState>(
              valueListenable: taskController.tasks,
              builder: (context, value, widget) {
                if (value is LoadingTask && value is! ErrorTask) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (value is ErrorTask) {
                  return EmptyList(label: value.msg);
                }

                if (value is EmptyTask) {
                  return EmptyList(label: "You have no task listed");
                }

                if (value is LoadedTask) {
                  final list =
                      value.list.where((e) => e.done == false).toList();

                  if (list.isEmpty) {
                    return EmptyList(label: "No tasks to do.");
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return TaskCard(model: list[index]);
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
