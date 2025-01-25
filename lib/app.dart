import 'package:flutter/material.dart';

import 'core/locator.dart';
import 'core/theme/app_theme.dart';
import 'ui/pages/base/base_page.dart';
import 'ui/shared/custom_snack.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: locator.get<CustomSnack>().snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      title: 'Taski',
      home: BasePage(),
    );
  }
}
