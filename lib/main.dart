import 'package:flutter/material.dart';
import 'package:taski/core/locator.dart';
import 'package:taski/repositories/local/config_hive.dart';

import 'app.dart';

Future<void> main() async {
  setupLocators();

  await ConfigHive.initialize();

  runApp(const MainApp());
}
