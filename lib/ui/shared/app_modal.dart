import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AppModal {
  static show({required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.defaultBorder),
          topRight: Radius.circular(AppTheme.defaultBorder),
        ),
      ),
      builder: (context) => widget,
    );
  }
}
