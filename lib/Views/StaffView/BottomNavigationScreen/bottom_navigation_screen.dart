import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/bottom_nav_controller.dart';
import 'package:renaissance/Utils/const.dart';
import '../../CommonViews/ProfileScreen/profile_screen.dart';
import '../AlertsScreen/alert_screen.dart';
import '../HomeScreen/home_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController controller =
        Get.put(BottomNavigationController());
    return Scaffold(
      body: GetBuilder(
          init: controller,
          builder: (_) {
            return [
              const HomeScreen(),
              const AlertScreen(),
              const ProfileScreen(),
            ][controller.currentIndex.value];
          }),
      bottomNavigationBar: GetBuilder(
          init: controller,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(gradient: gradientPrimary),
              height: 90.h,
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setCurrentIndex = 0;
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex == 0
                            ? white
                            : Colors.transparent,
                        boxShadow: controller.currentIndex == 0
                            ? const [
                                BoxShadow(
                                    color: Color(0xff000000),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: Offset(2, 4)),
                              ]
                            : [],
                      ),
                      child: Icon(
                        Icons.home_outlined,
                        color: controller.currentIndex == 0
                            ? buttonBgColor
                            : white,
                        size: 23.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setCurrentIndex = 1;
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex == 1
                            ? white
                            : Colors.transparent,
                        boxShadow: controller.currentIndex == 1
                            ? const [
                                BoxShadow(
                                    color: Color(0xff000000),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: Offset(2, 4)),
                              ]
                            : [],
                      ),
                      child: Icon(
                        CupertinoIcons.person_crop_rectangle,
                        color: controller.currentIndex == 1
                            ? buttonBgColor
                            : white,
                        size: 23.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setCurrentIndex = 2;
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex == 2
                            ? white
                            : Colors.transparent,
                        boxShadow: controller.currentIndex == 2
                            ? const [
                                BoxShadow(
                                    color: Color(0xff000000),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: Offset(2, 4)),
                              ]
                            : [],
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: controller.currentIndex == 2
                            ? buttonBgColor
                            : white,
                        size: 23.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
