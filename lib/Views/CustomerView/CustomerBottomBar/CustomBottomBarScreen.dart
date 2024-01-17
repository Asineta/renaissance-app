import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/bottom_nav_controller.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';
import '../../CommonViews/ProfileScreen/profile_screen.dart';
import '../CustomerHomeScreen/customer_home_screen.dart';
import '../MyCourses/my_courses_screen.dart';

class CustomerBottomScreen extends StatelessWidget {
  const CustomerBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController controller =
        Get.put(BottomNavigationController());
    return Scaffold(
      body: GetBuilder(
          init: controller,
          builder: (_) {
            return [
              const CustomerHomeScreen(),
              const MyCourseScreen(),
              // ChatListScreen(),
              const ProfileScreen(),
            ][controller.currentIndex.value];
          }),
      bottomNavigationBar: GetBuilder(
          init: controller,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(color: buttonBgColor),
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
                      padding: EdgeInsets.all(10.r),
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
                      child: Image.asset(
                        ImageConst.homeIcon,
                        color: controller.currentIndex == 0
                            ? buttonBgColor
                            : white,
                        fit: BoxFit.fill,
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
                      child: Image.asset(
                        ImageConst.alerts,
                        color: controller.currentIndex == 1
                            ? buttonBgColor
                            : white,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     controller.setCurrentIndex = 2;
                  //   },
                  //   child: Container(
                  //     height: 50.h,
                  //     width: 50.h,
                  //     padding: const EdgeInsets.all(9),
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: controller.currentIndex == 2
                  //           ? white
                  //           : Colors.transparent,
                  //       boxShadow: controller.currentIndex == 2
                  //           ? const [
                  //               BoxShadow(
                  //                   color: Color(0xff000000),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 9,
                  //                   offset: Offset(2, 4)),
                  //             ]
                  //           : [],
                  //     ),
                  //     child: Image.asset(
                  //       ImageConst.message,
                  //       color: controller.currentIndex == 2
                  //           ? buttonBgColor
                  //           : white,
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      controller.setCurrentIndex = 2;
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      padding: EdgeInsets.all(10.r),
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
                      child: Image.asset(
                        ImageConst.profileIcon,
                        color: controller.currentIndex == 2
                            ? buttonBgColor
                            : white,
                        fit: BoxFit.fill,
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
