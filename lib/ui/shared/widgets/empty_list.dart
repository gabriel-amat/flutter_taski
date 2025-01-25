import 'package:flutter/material.dart';
import 'package:taski/ui/shared/widgets/custom_svg.dart';

class EmptyList extends StatelessWidget {
  final String label;

  const EmptyList({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvg(image: "assets/list_icons.svg", height: 100),
          SizedBox(height: 8),
          Text(label)
        ],
      ),
    );
  }
}
