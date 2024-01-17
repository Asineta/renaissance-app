// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Views/CustomerView/TestScreen/test_screen.dart';
import 'package:renaissance/Widgets/chewie_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import '../../../Utils/text_theme.dart';
import '../../../Widgets/custom_appbar.dart';

class MyCourseDetailScreen extends StatefulWidget {
  var courseId;

  MyCourseDetailScreen({super.key, required this.courseId});

  @override
  State<MyCourseDetailScreen> createState() => _MyCourseDetailScreenState();
}

class _MyCourseDetailScreenState extends State<MyCourseDetailScreen> {
  Map<String, dynamic>? myCourseDetail;
  // late VideoPlayerController _videoController;
  // late Future<void> _initializeVideoPlayerFuture;
  // bool _isOverlayVisible = true;


  @override
  void initState() {
    super.initState();
    // fetchMyCoursesDetail().then((courseDetail) {
    //   var viderUrl = courseDetail['course_video'];
    //   _videoPlayerController = VideoPlayerController.networkUrl(viderUrl);
    //   _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    // });
    fetchCourseDetails();
  }

  @override
  void dispose() {
    super.dispose();
    // _videoController.dispose();
  }

  Future<void> fetchCourseDetails() async {
    try {
      var courseDetails = await fetchMyCoursesDetail();
      setState(() {
        myCourseDetail = courseDetails;
        // if (myCourseDetail != null) {
        //   // Initialize video controller with the video URL
        //   _videoController = VideoPlayerController.network(
        //     myCourseDetail!['course_video'],
        //   )
        //     ..initialize().then((_) {
        //       // Ensure the first frame is shown after the video is initialized
        //       setState(() {});
        //     });
        //   _initializeVideoPlayerFuture = _videoController.initialize();
        // }
      });
    } catch (e) {
      // Handle error
      print('Error fetching course details: $e');
    }
  }

  Future<Map<String, dynamic>> fetchMyCoursesDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/myCourseDetail.php';
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

  @override
  Widget build(BuildContext context) {
    var videoUrl = myCourseDetail?['course_video'];
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: true,
        title: "Course Detail",
        leading: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
            future: fetchMyCoursesDetail(),
            builder: (context, snapshot) {
              var myCourseDetail = snapshot.data;
              late List<dynamic> skills = myCourseDetail?["skills"];
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        myCourseDetail?['course_thumbnail'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Image.asset('assets/images/courseBg.png'),
                      Positioned(
                        bottom: -50.h,
                        right: 20.w,
                        child: GestureDetector(
                          onTap: () {
                            // Play or pause the video on tap
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildVideoDialog(videoUrl),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 120.h,
                                width: 170.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: blue),
                                child:
                                // videoUrl != null
                                //     ? FutureBuilder(
                                //         future: _initializeVideoPlayerFuture,
                                //         builder: (context, snapshot) {
                                //           if (snapshot.connectionState ==
                                //               ConnectionState.done) {
                                //             return AspectRatio(
                                //               aspectRatio: _videoController
                                //                   .value.aspectRatio,
                                //               child:
                                //                   VideoPlayer(_videoController),
                                //             );
                                //           } else {
                                //             return const Center(
                                //                 child:
                                //                     CircularProgressIndicator());
                                //           }
                                //         },
                                //       )
                                // :
                                Image.asset('assets/icons/play.png'),
                              ),
                              // if (_isOverlayVisible)
                              //   Positioned(
                              //     top: 27,
                              //     left: 50,
                              //     child: Center(
                              //       child: IconButton(
                              //         icon: _videoController.value.isPlaying
                              //             ? const Icon(
                              //                 Icons.pause,
                              //                 size: 40,
                              //                 color: Colors.red,
                              //               )
                              //             : const Icon(
                              //                 Icons.play_arrow,
                              //                 size: 40,
                              //                 color: Colors.red,
                              //               ),
                              //         onPressed: () {
                              //           // Toggle play/pause on overlay button tap
                              //           if (_videoController.value.isPlaying) {
                              //             _videoController.pause();
                              //           } else {
                              //             _videoController.play();
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      )
                    ],
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
                          myCourseDetail?['description'] ?? '',
                          style: kBodySmall.copyWith(
                              color: const Color(0xFF828282)),
                        ),
                        25.verticalSpace,
                        Text(
                          'Skill you will gain',
                          style: kBodyLarge.copyWith(
                              fontSize: 20.sp,
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
                            })
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
      bottomNavigationBar: FutureBuilder<Map<String, dynamic>>(
          future: fetchMyCoursesDetail(),
          builder: (context, snapshot) {
            var myCourseDetail = snapshot.data;
            return myCourseDetail?['enrollment_status'] != 0
                ? Container(
              alignment: Alignment.center,
              height: 59.h,
              width: double.infinity,
              color: Colors.grey,
              child: Text(
                'Completed',
                style: kBodyMediumSansBold.copyWith(color: Colors.white),
              ),
            )
                : GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TestScreen(
                              courseId: widget.courseId,
                            )));
              },
              child: Container(
                alignment: Alignment.center,
                height: 59.h,
                width: double.infinity,
                color: red,
                child: Text(
                  'Start Test',
                  style:
                  kBodyMediumSansBold.copyWith(color: Colors.white),
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildVideoDialog(String? videoUrl) {
    return Material(
      child: ChewieWidget(srcs: myCourseDetail!['course_video'],),
      // child: Stack(
      //   children: [
      //     SizedBox(
      //       width: double.maxFinite,
      //       child: videoUrl != null
      //           ? FutureBuilder(
      //         future: _initializeVideoPlayerFuture,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             return AspectRatio(
      //               aspectRatio: _videoController.value.aspectRatio,
      //               child: VideoPlayer(_videoController),
      //             );
      //           } else {
      //             return const Center(child: CircularProgressIndicator());
      //           }
      //         },
      //       )
      //           : Image.asset('assets/icons/play.png'),
      //     ),
      //     if (_isOverlayVisible)
      //       Positioned(
      //         top: 80,
      //         left: 110,
      //         child: Center(
      //           child: Obx(() {
      //             return IconButton(
      //               icon: _controller.isVideoPlayed.value
      //                   ? const Icon(
      //                 Icons.pause,
      //                 size: 60,
      //                 color: Colors.red,
      //               )
      //                   : const Icon(
      //                 Icons.play_arrow,
      //                 size: 60,
      //                 color: Colors.red,
      //               ),
      //               onPressed: () {
      //                 // Toggle play/pause on overlay button tap
      //                 if (_videoController.value.isPlaying) {
      //                   _videoController.pause();
      //                   _controller.isVideoPlayed.value = true;
      //                 } else {
      //                   _videoController.play();
      //                   _controller.isVideoPlayed.value = false;
      //                 }
      //               },
      //             );
      //           }),
      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}
