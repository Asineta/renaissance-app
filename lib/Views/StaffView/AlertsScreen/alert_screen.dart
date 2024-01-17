import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Widgets/custom_appbar.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  Future<Map<String, dynamic>> fetchAlertsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/allAlerts.php';
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
      appBar: buildCustomAppBar(
        title: "Alert Health Aides",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Alerts",
              style: kBodyLargeSansBold.copyWith(fontSize: 28.sp),
            ),
            10.verticalSpace,
            Divider(
              color: Colors.grey.withOpacity(0.7),
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
                                decoration: index.isEven
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
                                                color: index.isEven
                                                    ? onPrimary.withOpacity(0.8)
                                                    : Colors.white),
                                          ),
                                          Text(
                                            alerts[index]['message'],
                                            style: kBodyLabel.copyWith(
                                              color: index.isEven
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                          Container(
                                            width: 210.w,
                                            height: 1.h,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5.h),
                                            color: index.isEven
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
                                                      style:
                                                          kBodyLabel.copyWith(
                                                        color: index.isEven
                                                            ? textGrey
                                                            : white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Time: ${alerts[index]['time']}",
                                                      style:
                                                          kBodyLabel.copyWith(
                                                        color: index.isEven
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
                            });
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
