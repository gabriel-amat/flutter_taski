import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski/models/task_model.dart';

class ConfigHive {
  static Future<void> initialize() async {

    await Hive.initFlutter();
    
    //Adapter`s
    Hive.registerAdapter(TaskModelAdapter());
    
    //Box`s
    await Hive.openBox<TaskModel>(TaskModel.boxKey);
  }
}
