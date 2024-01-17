import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/forget_password_controller.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';
import 'package:renaissance/Widgets/custom_appbar.dart';
import 'package:renaissance/Widgets/custom_textfield.dart';

import '../../../../Widgets/custom_elevated_button.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GetBuilder(
            init: ForgetController(),
            builder: (forgetController) {
              return Form(
                key: forgetController.formkey,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(ImageConst.circlebg),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.verticalSpace,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: CustomBackButton(),
                            )),
                        Image.asset(
                          ImageConst.forgot,
                          // width: 70.h,
                          height: 168.h,
                        ),
                        10.verticalSpace,
                        Text(
                          "Forgot Password?",
                          style: kBodyLargeSansBold,
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: Text(
                            "Please enter the email address linked with your \naccount.",
                            style: kBodySmall.copyWith(color: textGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: CustomTextField(
                            controller: forgetController.emailController,
                            // validator: Utils.emailValidator,
                            hint: "Enter your email",
                            inputAction: TextInputAction.done,
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                          btnColor: btnGradient,
                          onTap: () {
                            Get.toNamed(AppRoutes.newPassword);
                          },
                          text: "Send Code",
                        ),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
