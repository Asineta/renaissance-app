import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/const.dart';

class CustomButton extends StatelessWidget {
  var onTap;
  String? text;
  var deco;
  var style;
  var width;
  Gradient? btnColor;

  CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.deco,
      this.style,
      this.width,
      this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      decoration: deco ??
          BoxDecoration(
              gradient: btnColor ?? gradientPrimary,
              borderRadius: BorderRadius.circular(100.r)),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text ?? "",
          style: style,
        ),
      ),
    );
  }
}
