import 'package:flutter/material.dart';
import 'package:taski/controllers/task/task_controller.dart';
import 'package:taski/ui/pages/base/widgets/custom_appbar.dart';
import 'package:taski/ui/pages/done/done_page.dart';
import 'package:taski/ui/pages/home/home_page.dart';
import 'package:taski/ui/pages/search/search_page.dart';
import 'package:taski/ui/shared/app_modal.dart';
import 'package:taski/ui/shared/widgets/modal_create_task.dart';

import '../../../core/locator.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final taskController = locator.get<TaskController>();
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    initData();
    super.initState();
  }

  initData() {
    taskController.getTasks();
  }

  void onCreate() {
    AppModal.show(context: context, widget: ModalCreateTask());
  }

  void onItemTapped(int page) {
    pageController.jumpToPage(page);
    setState(() => currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onCreate,
        icon: Icon(Icons.add),
        label: Text("Create"),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchPage(),
          DonePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Todo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_rounded),
            label: "Done",
          ),
        ],
      ),
    );
  }
}
