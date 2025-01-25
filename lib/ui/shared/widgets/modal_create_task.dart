import 'package:flutter/material.dart';
import 'package:taski/models/task_model.dart';
import 'package:taski/ui/shared/custom_snack.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/task/task_controller.dart';
import '../../../core/locator.dart';
import '../../../core/theme/app_text.dart';

class ModalCreateTask extends StatefulWidget {
  const ModalCreateTask({super.key});

  @override
  State<ModalCreateTask> createState() => _ModalCreateTaskState();
}

class _ModalCreateTaskState extends State<ModalCreateTask> {
  final taskController = locator.get<TaskController>();
  final snack = locator.get<CustomSnack>();
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final content = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) return;
    
    final uuid = Uuid();

    final newTask = TaskModel(
      id: uuid.v4(),
      title: title.text,
      content: content.text,
      done: false,
    );

    taskController.addTask(data: newTask);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_box_outline_blank_rounded,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: TextFormField(
                    controller: title,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um texto';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What`s in your mind?",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                Flexible(
                  child: TextFormField(
                    controller: content,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um texto';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add note...",
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSubmit,
                child: Text(
                  "Create",
                  style: AppText.title.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
