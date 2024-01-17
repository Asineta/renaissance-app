import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';
import 'package:renaissance/Views/CustomerView/MyCourseDetailScreen/my_course_detail_screen.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Widgets/custom_appbar.dart';
import '../CourseDetailScreen/course_detail_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // late Future<Map<String, dynamic>> fetchCourseData = fetchData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    print("Checking login status");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('loggedIn');
    String? type = prefs.getString('type');

    if (isLoggedIn != null && isLoggedIn) {
      // Get the last login timestamp from SharedPreferences
      int? lastLoginTimestamp = prefs.getInt('lastLoginTimestamp');

      if (lastLoginTimestamp != null) {
        // Get the current timestamp
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

        // Calculate the time difference in hours
        int timeDifferenceInHours =
            (currentTimestamp - lastLoginTimestamp) ~/ (1000 * 60 * 60);

        // Check if the time difference exceeds 24 hours
        if (timeDifferenceInHours >= 24 || type != "user") {
          prefs.setBool('loggedIn', false);
          // Here you can navigate to the login screen
          print("Session expired, please log in again.");
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        // Handle the case where lastLoginTimestamp is null (this should not normally happen)
        prefs.setBool('loggedIn', false);
        print("Session data corrupted, please log in again.");
      }
    }
  }

  /// The function `getUserData` retrieves the user's name and profile picture from shared preferences
  /// and returns them as a list of strings.
  ///
  /// Returns:
  ///   a `Future` object that resolves to a `List` of `String` values.
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name') ?? '';
    var profilePic = prefs.getString('profile_pic') ?? '';
    var data = [name, profilePic];
    return data;
  }

  Future<Map<String, dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/userDashboard.php';
    var data = {
      'user_id': userId,
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      if (res['error'] == "false") {
        // Convert the 'res' map to a JSON string
        // String jsonString = jsonEncode(res);
        // print("JsonString ****: $jsonString");

        // Store the JSON string in SharedPreferences
        // await prefs.setString('stopWorkOrderData', jsonString);

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
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: true,
        title: "Home Health Aides",
        // action: [
        //   InkWell(
        //     onTap: () {
        //       Get.toNamed(AppRoutes.notifications);
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        //       child: Icon(
        //         Icons.notifications,
        //         color: onPrimary,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              FutureBuilder<List<String>>(
                future: getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // or some other placeholder
                  } else {
                    if (snapshot.hasError) {
                      // Handle error
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Access data from snapshot
                      List<String>? userData = snapshot.data;

                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.network(
                              userData![
                                  1], // Assuming the second element is the profile pic URL
                              height: 75.h,
                              width: 75.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          20.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back!",
                                style: kBodySmall,
                              ),
                              Text(
                                "Hi ${userData[0]}..", // Assuming the first element is the name
                                style: kBodyLargeSansBold.copyWith(
                                    fontSize: 28.sp),
                              ),
                            ],
                          ),
                          Image.asset(
                            ImageConst.hand,
                            height: 35.h,
                            width: 35.h,
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
              10.verticalSpace,
              Divider(
                color: Colors.grey.withOpacity(0.7),
              ),
              10.verticalSpace,
              // CustomTextField(
              //   readOnly: true,
              //   onTap: () {
              //     Get.toNamed(AppRoutes.searchCourse);
              //   },
              //   hint: "Search",
              //   suffix: const Icon(Icons.search),
              // ),
              // 10.verticalSpace,
              Text(
                "Current Courses",
                style: kBodyMediumSansBold.copyWith(fontSize: 22.sp),
              ),
              10.verticalSpace,
              Text(
                "Keep learning to make progress",
                style: kBodyMedium,
              ),
              10.verticalSpace,
              Divider(
                thickness: 2,
                color: Colors.grey.withOpacity(0.7),
              ),
              10.verticalSpace,
              Text(
                "Course By",
                style: kBodyMedium,
              ),
              Text(
                "By Renaissance",
                style: kBodyLabel,
              ),
              10.verticalSpace,

              FutureBuilder<Map<String, dynamic>>(
                  future: fetchData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      var courseData = snapshot.data!;
                      List<dynamic> currentCourses =
                          courseData['currentCourses'];
                      List<dynamic> offeredCourses =
                          courseData['offeredCourses'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 195.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
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
                                      // Get.toNamed(AppRoutes.myCourseDetail);
                                    },
                                    child: CourseCard(
                                      data: currentCourses[index],
                                    ));
                              },
                            ),
                          ),
                          10.verticalSpace,
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Offered Courses",
                                style: kBodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.courseList);
                                },
                                child: Text(
                                  "View All",
                                  style: kBodySmallSansBold.copyWith(
                                      color: primary),
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          SizedBox(
                            height: 195.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: offeredCourses.length,
                              itemBuilder: (context, index) {
                                return CourseCard(
                                  key: UniqueKey(),
                                  type: "offered",
                                  index: index + 1,
                                  data: offeredCourses[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data found'));
                    }
                  }),

              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  var data;
  String type;
  bool vertical;
  int index;

  CourseCard({
    super.key,
    required this.data,
    this.vertical = false,
    this.type = "current",
    this.index = 1,
  });

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      height: 195.h,
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
        crossAxisAlignment: type == "offered"
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Course 1 to 7",
              //     overflow: TextOverflow.ellipsis, style: kBodyLabel),
              // 10.verticalSpace,
              Text(
                data['course_name'],
                overflow: TextOverflow.ellipsis,
                style: kBodyLargeSansBold.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          Icon(
            Icons.more_horiz,
            color: buttonBgColor,
          ),
          const Spacer(),
          if (type == "offered")
            Text(
              "You may join this course whenever you're ready",
              style: kBodyLabel,
            ),
          if (type == "offered") 10.verticalSpace,
          if (type == "offered")
            CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetailScreen(
                                courseId: data['course_id'],
                              )));

                  // Get.toNamed(AppRoutes.courseDetail);
                },
                text: "Enroll Now"),
          // if (type == "current")
          // LinearProgressIndicator(
          //   value: 0.75,
          //   minHeight: 10.h,
          //   backgroundColor: Colors.grey.shade400,
          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          // ),
          if (type == "current") 5.verticalSpace,
          // if (type == "current")
          //   Text(
          //     "Overall Progress 76%",
          //     style: kBodyLabel,
          //   ),
          // if (type == "current") 10.verticalSpace,
        ],
      ),
    );
  }
}
