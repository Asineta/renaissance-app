import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/const.dart';
import '../../../Controllers/my_course_controller.dart';
import '../../../Widgets/custom_appbar.dart';
import '../CustomerHomeScreen/customer_home_screen.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CourseListController controller = Get.put(CourseListController());
    return Scaffold(
        appBar: buildCustomAppBar(
            gradient: true, title: "Course Listing", leading: true),
        body: GetBuilder(
            init: controller,
            builder: (_) {
              return Column(
                children: [
                  10.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          index: index + 1,
                          vertical: true,
                          type: "offered",
                          data: [],
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}
