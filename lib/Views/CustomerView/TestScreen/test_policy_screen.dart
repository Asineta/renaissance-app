import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import '../../../Utils/const.dart';
import '../../../Widgets/custom_appbar.dart';

class TestPolicyScreen extends StatelessWidget {
  const TestPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        leading: true,
        gradient: true,
        title: "Test Policy",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Our website uses cookies.\n",
              style: kBodyMediumSansBold,
            ),
            Text(
              '''A cookie is a file containing an identifier (a string of letters and numbers) that is sent by a web server to a web browser and is stored by the browser. The identifier is then sent back to the server each time the browser requests a page from the server. \nCookies may be either “persistent” cookies or “session” cookies: a persistent cookie will be stored by a web browser and will remain valid until its set expiry date, unless deleted by the user before the expiry date; a session cookie, on the other hand, will expire at the end of the user session, when the web browser is closed. Cookies do not typically contain any information that personally identifies a user, but personal information that we store about you may be linked to the information stored in and obtained from cookies. \nWe use may use both session and persistent cookies on our website. The names of the cookies that we use on our website, and the purposes for which they are used, are set out below:''',
              style: kBodySmall,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.offNamed(AppRoutes.testScreen);
        },
        child: Container(
          alignment: Alignment.center,
          height: 80.h,
          width: 1.sw,
          decoration: BoxDecoration(color: red),
          child: Text(
            "Start Test",
            style: kBodyLarge.copyWith(color: white),
          ),
        ),
      ),
    );
  }
}
