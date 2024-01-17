import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';

import '../Utils/text_theme.dart';
import '../Utils/const.dart';

showSuccessSheet({
  String? title,
  String? subtitle,
  double? height,
  required String buttonText,
  required void Function() onTap,
}) {
  Get.bottomSheet(
    Container(
      height: height ?? 350.h,
      padding:
          EdgeInsets.symmetric(vertical: 15.h, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: ClipRRect(
                    borderRadius: radius * 2,
                    child: Lottie.asset(
                      "assets/images/check-green.json",
                      height: 160.h,
                      // width: 160.w,
                      fit: BoxFit.fill,
                      repeat: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: verticalPadding),

          /// Title
          if (title != null)
            Text(
              title,
              style: kBodyLargeSansBold,
              textAlign: TextAlign.center,
            ),
          if (title != null) 20.verticalSpace,

          /// Subtitle
          if (subtitle != null)
            Text(
              subtitle,
              style: kBodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,

            ),
          if (subtitle != null) 20.verticalSpace,
          CustomButton(text: buttonText, onTap: onTap),
        ],
      ),
    ),
  );
}
