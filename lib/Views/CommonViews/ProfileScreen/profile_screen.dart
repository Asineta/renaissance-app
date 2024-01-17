import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Routes/app_routes.dart';
import '../../../Widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<String> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('profile_pic') ?? '';
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: !Utils.isStaff(),
        title: "My Profile",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 40.h),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  FutureBuilder<String>(
                    future: getUserImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // or some other placeholder
                      } else {
                        return Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: hintColor),
                              shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.w),
                            child: Image.network(
                              snapshot.data.toString(),
                              width: 125.w,
                              height: 125.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(6.w),
                  //   decoration: BoxDecoration(
                  //       color: white,
                  //       border: Border.all(color: hintColor),
                  //       shape: BoxShape.circle),
                  //   child: Icon(
                  //     Icons.camera_alt_outlined,
                  //     color: textBlack,
                  //   ),
                  // ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.editProfile);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textGrey.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  Text(
                    'Edit Profile',
                    style: kBodySmall.copyWith(color: textGrey),
                  ),
                  40.horizontalSpace,
                  Icon(
                    Icons.arrow_forward,
                    color: textGrey,
                    size: 20.sp,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.changePass);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textGrey.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  Text(
                    'Change Password',
                    style: kBodySmall.copyWith(color: textGrey),
                  ),
                  40.horizontalSpace,
                  Icon(
                    Icons.arrow_forward,
                    color: textGrey,
                    size: 20.sp,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.privacy);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textGrey.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  Text(
                    'Privacy Policy',
                    style: kBodySmall.copyWith(color: textGrey),
                  ),
                  40.horizontalSpace,
                  Icon(
                    Icons.arrow_forward,
                    color: textGrey,
                    size: 20.sp,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.terms);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textGrey.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  Text(
                    'Terms & Conditions',
                    style: kBodySmall.copyWith(color: textGrey),
                  ),
                  40.horizontalSpace,
                  Icon(
                    Icons.arrow_forward,
                    color: textGrey,
                    size: 20.sp,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.contact);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textGrey.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  Text(
                    'Contact Us',
                    style: kBodySmall.copyWith(color: textGrey),
                  ),
                  40.horizontalSpace,
                  Icon(
                    Icons.arrow_forward,
                    color: textGrey,
                    size: 20.sp,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('loggedIn');
                await prefs.remove('type');
                await prefs.remove('user_id');
                await prefs.remove('name');
                await prefs.remove('email');
                await prefs.remove('status');
                await prefs.remove('profile_pic');

                // redirect to login page
                Get.offAllNamed(AppRoutes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: kBodySmall.copyWith(color: white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
