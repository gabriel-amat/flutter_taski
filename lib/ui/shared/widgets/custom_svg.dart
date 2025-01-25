import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomSvg extends StatelessWidget {
  final String image;
  final double height;

  const CustomSvg({
    super.key,
    required this.image,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      semanticsLabel: image,
      height: height,
      width: height,
      fit: BoxFit.scaleDown,
    );
  }
}
