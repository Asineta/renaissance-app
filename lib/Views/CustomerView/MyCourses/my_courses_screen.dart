import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Controllers/my_course_controller.dart';
import '../../../Widgets/custom_appbar.dart';
import '../CustomerHomeScreen/customer_home_screen.dart';
import 'package:http/http.dart' as http;

import '../MyCourseDetailScreen/my_course_detail_screen.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  Future<Map<String, dynamic>> fetchAllCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/allCourses.php';
    var data = {
      'user_id': userId,
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      if (res['error'] == "false") {
        return res['data'];
      } else {
        throw Exception('Failed to load courses');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    CourseListController controller = Get.put(CourseListController());
    return Scaffold(
        appBar: buildCustomAppBar(
          gradient: true,
          title: "My Courses",
        ),
        body: GetBuilder(
            init: controller,
            builder: (_) {
              return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    10.verticalSpace,
                    TabBar(
                      indicatorColor: Colors.transparent,
                      indicatorPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          child: CustomButton(
                            style: controller.currentIndex.value == 0
                                ? kBodySmallSansBold.copyWith(color: white)
                                : kBodySmall,
                            deco: controller.currentIndex.value == 0
                                ? null
                                : BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                            text: "Current",
                            onTap: () {
                              controller.setCurrentIndex = 0;
                            },
                          ),
                        ),
                        Tab(
                          child: CustomButton(
                            style: controller.currentIndex.value == 1
                                ? kBodySmallSansBold.copyWith(color: white)
                                : kBodySmall,
                            deco: controller.currentIndex.value == 1
                                ? null
                                : BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                            text: "Completed",
                            onTap: () {
                              controller.setCurrentIndex = 1;
                            },
                          ),
                        ),
                      ],
                    ),
                    if (controller.currentIndex.value == 0)
                      FutureBuilder<Map<String, dynamic>>(
                          future: fetchAllCourses(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData && snapshot.data != null) {
                              var courseData = snapshot.data!;
                              List<dynamic> currentCourses =
                                  courseData['currentCourses'];

                              return Expanded(
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPadding),
                                  itemCount: currentCourses.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyCourseDetailScreen(
                                                      courseId:
                                                          currentCourses[index]
                                                              ['course_id'],
                                                    )));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: CourseCard(
                                            data: currentCourses[index]),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Container();
                          }),

                    if (controller.currentIndex.value == 1)
                      FutureBuilder<Map<String, dynamic>>(
                          future: fetchAllCourses(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData && snapshot.data != null) {
                              var courseData = snapshot.data!;
                              List<dynamic> completedCourses =
                                  courseData['completedCourses'];
                              print('COurses: ${completedCourses}');
                              return Expanded(
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPadding),
                                  itemCount: completedCourses.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyCourseDetailScreen(
                                                      courseId:
                                                          completedCourses[
                                                                  index]
                                                              ['course_id'],
                                                    )));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: CompleteCourseCard(
                                          data: completedCourses[index],
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyCourseDetailScreen(
                                                          courseId:
                                                              completedCourses[
                                                                      index]
                                                                  ['course_id'],
                                                        )));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Container();
                          }),
                    // 90.verticalSpace,
                  ],
                ),
              );
            }));
  }
}

class CompleteCourseCard extends StatelessWidget {
  var data;
  var onTap;
  String type;
  bool vertical;
  int index;

  CompleteCourseCard({
    super.key,
    required this.data,
    this.onTap,
    this.vertical = false,
    this.type = "current",
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: vertical ? double.maxFinite : 0.89.sw,
      margin: vertical
          ? EdgeInsets.symmetric(vertical: 10.h)
          : EdgeInsets.only(right: 20.w),
      padding:
          EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xffE4E4E4),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data['course_name'],
                  overflow: TextOverflow.ellipsis,
                  style: kBodyLargeSansBold.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: buttonBgColor,
              ),
            ],
          ),
          // const Spacer(),
          // LinearProgressIndicator(
          //   value: 0.75,
          //   minHeight: 8.h,
          //   backgroundColor: Colors.grey.shade400,
          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          // ),
          // 5.verticalSpace,
          // Text(
          //   "Overall Progress 100%",
          //   style: kBodyLabel,
          // ),
          5.verticalSpace,
          CustomButton(
              deco: BoxDecoration(
                  color: buttonBgColor,
                  borderRadius: BorderRadius.circular(100.r)),
              onTap: onTap,
              text: "View Detail"),
        ],
      ),
    );
  }
}
