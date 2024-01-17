import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/utils.dart';
import 'package:renaissance/Views/StaffView/BottomNavigationScreen/bottom_navigation_screen.dart';
import '../Utils/text_theme.dart';
import '../Utils/const.dart';
import '../Views/CustomerView/CustomerBottomBar/CustomBottomBarScreen.dart';

PreferredSize buildCustomAppBar(
    {title, leading = false, action = null, gradient = false}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: gradient
          ? BoxDecoration(color: buttonBgColor)
          : BoxDecoration(gradient: gradientPrimary),
      child: AppBar(
        leading: leading
            ? Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomBackButton(gradient: gradient))
            : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          title,
          style: kBodyLargeSansBold.copyWith(
              color: gradient ? const Color(0xffd3ac40) : Colors.white,
              fontSize: 25.sp),
        ),
        actions: action,
      ),
    ),
  );
}

class CustomBackButton extends StatelessWidget {
  bool gradient;

  CustomBackButton({super.key, this.gradient = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Utils.isStaff()
            ? Get.off(() => const BottomNavigationScreen())
            : Get.off(() => const CustomerBottomScreen());
      },
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: 60.h,
        decoration: gradient
            ? BoxDecoration(
                gradient: gradientPrimary,
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                color: buttonBgColor,
                shape: BoxShape.circle,
              ),
        child: Icon(
          Icons.arrow_back,
          color: white,
        ),
      ),
    );
  }
}
