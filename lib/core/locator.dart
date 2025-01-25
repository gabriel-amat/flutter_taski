import 'package:get_it/get_it.dart';
import 'package:taski/controllers/task/task_controller.dart';
import 'package:taski/repositories/local/task_local_service.dart';
import 'package:taski/ui/shared/custom_snack.dart';

final locator = GetIt.instance;

setupLocators() {
  locator.registerSingleton(
    TaskController(localService: TaskLocalService()),
  );

  locator.registerLazySingleton<CustomSnack>(() => CustomSnack());
}
