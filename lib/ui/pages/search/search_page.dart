import 'package:flutter/material.dart';
import 'package:taski/controllers/task/task_controller.dart';
import 'package:taski/models/task_model.dart';
import 'package:taski/ui/shared/custom_snack.dart';
import 'package:taski/ui/shared/widgets/empty_list.dart';
import 'package:taski/ui/shared/widgets/task_card.dart';

import '../../../core/locator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final snack = locator.get<CustomSnack>();
  final taskController = locator.get<TaskController>();
  final searchText = TextEditingController();

  List<TaskModel> resultList = [];

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  Future<void> onChangeText(String? value) async {
    if (value == null) return;
    if (value.isEmpty) return;

    resultList = await taskController.searchTodos(query: value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          TextFormField(
            controller: searchText,
            onChanged: onChangeText,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search...",
              suffixIcon: IconButton(
                onPressed: () {
                  searchText.clear();
                  resultList = [];
                  setState(() {});
                },
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          Expanded(
            child: resultList.isEmpty
                ? EmptyList(label: "Nenhum item encontrado")
                : ListView.builder(
                    padding: EdgeInsets.only(top: 22),
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(model: resultList[index]);
                    },
                  ),
          )
        ],
      ),
    );
  }
}
