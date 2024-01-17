import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            Image.asset(
              ImageConst.onBoard,
              height: 0.6.sh,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: 25.h),
                decoration: BoxDecoration(
                  color: white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  height: 0.4.sh,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Caring with a  Commitment to Quality",
                        style: kBodyLargeSansBold,
                        textAlign: TextAlign.center,
                      ),
                      10.verticalSpace,
                      Text(
                        "We understand the importance of maintaining independence and quality of life, and we work closely with our clients and their families to create personalized care plans",
                        style: kBodySmall.copyWith(color: textGrey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.intro);
        },
        child: Container(
            alignment: Alignment.center,
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: primary, spreadRadius: 3, blurRadius: 7)
              ],
              gradient: gradientPrimary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: white,
            )),
      ),
    );
  }
}
