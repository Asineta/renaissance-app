// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Widgets/success_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/text_theme.dart';
import '../../../Widgets/custom_appbar.dart';
import '../MyCourseDetailScreen/my_course_detail_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  var courseId;
  CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoursesDetail();
  }

  //****  API for course details ****//
  Future<Map<String, dynamic>> fetchCoursesDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/courseDetail.php';
    var data = {
      'course_id': widget.courseId,
      'user_id': userId,
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      if (res['error'] == "false") {
        return res['data'];
      } else {
        throw Exception('Failed to load courses detail');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load courses detail');
    }
  }

//**** Function for Enroll Course ****//
  Future<void> enrollCourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/enrollCourse.php';
    var data = {
      'course_id': widget.courseId,
      'user_id': userId,
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          showSuccessSheet(
              buttonText: 'Okay',
              title: 'Congratulations',
              subtitle: 'You Successfully enrolled',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCourseDetailScreen(
                              courseId: widget.courseId,
                            )));
              });
        } else {
          // throw Exception('Incorrect username or password try again.');
          setState(() {
            Fluttertoast.showToast(
                msg: res['data'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
      } else {
        throw Exception('Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: true,
        title: "Course Detail",
        leading: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<Map<String, dynamic>>(
            future: fetchCoursesDetail(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Handle the case where data is not available yet.
                return const Center(child: CircularProgressIndicator());
              }
              var courseDetailData = snapshot.data;
              late List<dynamic> skills = courseDetailData?["skills"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 330.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(gradient: gradientPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'This course is part of the',
                            style: kBodyLarge.copyWith(
                                fontSize: 22.sp, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: ' Professional Certificate',
                            style: kBodyLarge.copyWith(
                                fontSize: 22.sp, fontWeight: FontWeight.w700),
                          ),
                        ])),
                        40.verticalSpace,
                        Text(
                          courseDetailData?['course_name'] ?? '',
                          style: kBodyLarge.copyWith(
                              fontSize: 25.sp, fontWeight: FontWeight.w700),
                        ),
                        40.verticalSpace,
                        // Row(
                        //   children: [
                        //     for (int i = 0; i < 5; i++)
                        //       Icon(
                        //         Icons.star,
                        //         color: textBlack,
                        //         size: 22.sp,
                        //       ),
                        //     13.horizontalSpace,
                        //     Text('4.8 (49k)', style: kBodySmall)
                        //   ],
                        // ),
                        // 16.verticalSpace,
                        Text(
                          'Offered By',
                          style: kBodyMedium,
                        ),
                        Image.asset(
                          'assets/images/courseAppLogo.png',
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 16.h, left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About this Course',
                          style: kBodyLarge.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: buttonBgColor),
                        ),
                        25.verticalSpace,
                        Text(
                          courseDetailData?['description'],

                          // 'Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the  industry\'s standard dummy text ever since the 1500s,  when an unknown printer took a galley of type and  scrambled it to make a type specimen book. It has  survived not only five centuries, but also the leap  into electronic typesetting, remaining essentially  unchanged.',
                          style: kBodySmall.copyWith(
                              color: const Color(0xFF828282)),
                        ),
                        25.verticalSpace,
                        Text(
                          'Skills you will gain',
                          style: kBodyLarge.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: buttonBgColor),
                        ),
                        25.verticalSpace,
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: true,
                            itemCount: skills.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 40.w),
                                child: Text(
                                  skills[index],
                                  // 'Lorem Ipsum',
                                  style: kBodySmall.copyWith(color: hintColor),
                                ),
                              );
                            }),
                        // Wrap(
                        //   spacing: 10,
                        //   runSpacing: 10,
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xFFEEEEEE),
                        //         borderRadius: BorderRadius.circular(30.r),
                        //       ),
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 12.h, horizontal: 40.w),
                        //       child: Text(
                        //         'Lorem Ipsum',
                        //         style: kBodySmall.copyWith(color: hintColor),
                        //       ),
                      ],
                    ),
                  ),
                  // Container(
                  //   // height: 280.h,
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFFEEEEEE),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'Syllabus:  What you will learn in this course',
                  //         style: kBodyLargeSansBold.copyWith(
                  //             fontSize: 20.sp, color: buttonBgColor),
                  //       ),
                  //       10.verticalSpace,
                  //       ListTileTheme(
                  //         contentPadding: const EdgeInsets.all(0),
                  //         dense: true,
                  //         horizontalTitleGap: -8.0,
                  //         minLeadingWidth: 0,
                  //         child: ExpansionTile(
                  //           tilePadding: EdgeInsets.zero,
                  //           textColor: textBlack,
                  //           collapsedTextColor: textBlack,
                  //           iconColor: textBlack,
                  //           collapsedIconColor: textBlack,
                  //           title: Text(
                  //             'Week 1:   Lorem Ipsum is simply dummy text',
                  //             style: kBodySmall,
                  //           ),
                  //           children: <Widget>[
                  //             ListTile(
                  //               title: Text(
                  //                 'data',
                  //                 style: kBodySmall,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       10.verticalSpace,
                  //       ListTileTheme(
                  //         contentPadding: const EdgeInsets.all(0),
                  //         dense: true,
                  //         horizontalTitleGap: 0.0,
                  //         minLeadingWidth: 0,
                  //         child: ExpansionTile(
                  //           tilePadding: EdgeInsets.zero,
                  //           textColor: textBlack,
                  //           collapsedTextColor: textBlack,
                  //           iconColor: textBlack,
                  //           collapsedIconColor: textBlack,
                  //           title: Text(
                  //             'Week 2:   Lorem Ipsum ',
                  //             style: kBodySmall,
                  //           ),
                  //           children: <Widget>[
                  //             ListTile(
                  //               title: Text(
                  //                 'data',
                  //                 style: kBodySmall,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       ListTileTheme(
                  //         contentPadding: const EdgeInsets.all(0),
                  //         dense: true,
                  //         horizontalTitleGap: -8.0,
                  //         minLeadingWidth: 0,
                  //         child: ExpansionTile(
                  //           tilePadding: EdgeInsets.zero,
                  //           textColor: textBlack,
                  //           collapsedTextColor: textBlack,
                  //           iconColor: textBlack,
                  //           collapsedIconColor: textBlack,
                  //           title: Text(
                  //             'Week 3:   Lorem Ipsum is simply dummy text',
                  //             style: kBodySmall,
                  //           ),
                  //           children: <Widget>[
                  //             ListTile(
                  //               title: Text(
                  //                 'data',
                  //                 style: kBodySmall,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Text(
                        //       '4.8',
                        //       style:
                        //           kBodyLargeSansBold.copyWith(color: buttonBgColor),
                        //     ),
                        //     13.horizontalSpace,
                        //     for (int i = 0; i < 5; i++)
                        //       Icon(
                        //         Icons.star,
                        //         color: buttonBgColor,
                        //         size: 22.sp,
                        //       ),
                        //   ],
                        // ),
                        // 10.verticalSpace,
                        Text(
                          'Instructors',
                          style: kBodyMediumSansBold.copyWith(
                              fontSize: 20.sp, color: buttonBgColor),
                        ),
                        5.verticalSpace,
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset('assets/images/icon.png'),
                            ),
                            10.horizontalSpace,
                            Image.asset('assets/images/icon-name.png'),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFFEEEEEE),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Syllabus:  What you will learn in this course',
                  //         style: kBodyLargeSansBold.copyWith(
                  //             fontSize: 20.sp, color: buttonBgColor),
                  //       ),
                  //       16.verticalSpace,
                  //       ListView.separated(
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: 5,
                  //         shrinkWrap: true,
                  //         itemBuilder: (context, index) {
                  //           return Row(
                  //             children: [
                  //               Image.asset('assets/icons/check.png'),
                  //               15.horizontalSpace,
                  //               Text(
                  //                 'Dummy text',
                  //                 style: kBodySmall.copyWith(fontSize: 17.sp),
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //         separatorBuilder: (BuildContext context, int index) {
                  //           return SizedBox(
                  //             height: 10.h,
                  //           );
                  //         },
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get a Certificate',
                          style: kBodyLargeSansBold.copyWith(
                              fontSize: 20.sp, color: buttonBgColor),
                        ),
                        Row(
                          children: [
                            Text(
                              'Shareable on',
                              style: kBodySmall.copyWith(color: hintColor),
                            ),
                            10.horizontalSpace,
                            Image.asset('assets/images/linkedin.png'),
                          ],
                        ),
                        10.verticalSpace,
                        Image.asset('assets/images/certificate.png'),
                      ],
                    ),
                  ),
                  55.verticalSpace,
                ],
              );
            }),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            Container(
              height: 350.h,
              padding: EdgeInsets.symmetric(
                  vertical: 15.h, horizontal: horizontalPadding),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to enroll in \nthis Course?',
                    style: kBodyLarge.copyWith(fontSize: 25.sp),
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  Row(
                    children: [
                      25.horizontalSpace,
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBgColor),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Back'),
                      )),
                      15.horizontalSpace,
                      Expanded(
                          child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: primary),
                        onPressed: () {
                          enrollCourse();
                        },
                        child: const Text('Yes'),
                      )),
                      25.horizontalSpace,
                    ],
                  )
                ],
              ),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: 59.h,
          width: double.infinity,
          color: blue,
          child: Text(
            'Enroll Now',
            style: kBodyMediumSansBold.copyWith(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
