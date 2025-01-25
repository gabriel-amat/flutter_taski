import 'package:flutter/material.dart';
import 'package:taski/ui/shared/widgets/custom_svg.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CustomSvg(image: "assets/check_icon.svg", height: 20),
      title: Text(
        "Taski",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      titleSpacing: 0,
      centerTitle: false,
      actions: [
        Text(
          "Gabriel",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        SizedBox(width: 8),
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage("assets/me.jpeg"),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
