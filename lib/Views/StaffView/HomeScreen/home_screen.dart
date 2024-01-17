import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_staff_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name') ?? '';
    var profilePic = prefs.getString('profile_pic') ?? '';
    var data = [name, profilePic];
    return data;
  }

  Future<Map<String, dynamic>> fetchAlertsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/staffDashboard.php';
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
    return Scaffold(
      appBar: buildCustomStaffAppBar(
        title: "Home Health Aides",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            FutureBuilder<List<String>>(
              future: getUserData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
                              style:
                                  kBodyLargeSansBold.copyWith(fontSize: 28.sp),
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
            Text(
              "Recent Alerts!",
              style: kBodyLarge,
            ),
            10.verticalSpace,
            Expanded(
              child: Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: const Color(0xffE4E4E4),
                  border: Border.all(color: Colors.black),
                ),
                child: FutureBuilder<Map<String, dynamic>>(
                    future: fetchAlertsData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        var alertsData = snapshot.data!;
                        List<dynamic> alerts = alertsData['alerts'];

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10.w, top: 10.h, bottom: 10.h),
                              decoration: index != 0
                                  ? BoxDecoration(
                                      color: const Color(0xffE4E4E4),
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                    )
                                  : BoxDecoration(
                                      gradient: gradientPrimary,
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                    ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(
                                  //   ImageConst.profile,
                                  //   height: 100.h,
                                  //   width: 100.h,
                                  // ),
                                  10.horizontalSpace,
                                  SizedBox(
                                    width: 260.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          alerts[index]['subject'],
                                          overflow: TextOverflow.ellipsis,
                                          style: kBodyLargeSansBold.copyWith(
                                              fontSize: 20.sp,
                                              color: index != 0
                                                  ? onPrimary.withOpacity(0.8)
                                                  : Colors.white),
                                        ),
                                        Text(
                                          alerts[index]['message'],
                                          style: kBodyLabel.copyWith(
                                            color: index != 0
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                        Container(
                                          width: 410.w,
                                          height: 1.h,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          color: index != 0
                                              ? textGrey.withOpacity(0.7)
                                              : Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Date: ${alerts[index]['date']}",
                                                    style: kBodyLabel.copyWith(
                                                      color: index != 0
                                                          ? textGrey
                                                          : white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Time: ${alerts[index]['time']}",
                                                    style: kBodyLabel.copyWith(
                                                      color: index != 0
                                                          ? textGrey
                                                          : white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data found'));
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
