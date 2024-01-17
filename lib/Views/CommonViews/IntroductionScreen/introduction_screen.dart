import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          // color: primary,
          image: DecorationImage(
              image: AssetImage(
                ImageConst.intro,
              ),
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(primary, BlendMode.hardLight)),
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 10,
            ),
            Image.asset(
              ImageConst.splash,
              width: 254.w,
              height: 121.h,
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonBgColor),
              onPressed: () {
                Get.offAllNamed(AppRoutes.login);
              },
              child: const Text("Sign in with Email"),
            ),
            5.verticalSpace,
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xff3B5998),
            //   ),
            //   onPressed: () {},
            //   child: const Text("Sign in with Facebook"),
            // ),
            // 5.verticalSpace,
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: red),
            //   onPressed: () {},
            //   child: const Text("Sign in with Gmail"),
            // ),
            // 5.verticalSpace,
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: buttonBgColor
            //   ),
            //   onPressed: () {},
            //   child: const Text("Sign in with Apple"),
            // ),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: kBodySmall,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                  child: Text(
                    "\tSign Up",
                    style: kBodySmallSansBold.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
