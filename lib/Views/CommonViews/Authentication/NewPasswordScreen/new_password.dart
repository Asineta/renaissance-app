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
import '../../../../Widgets/success_dialogue.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GetBuilder(
              init: ForgetController(),
              builder: (forgetController) {
                return Form(
                  key: forgetController.newPassFormkey,
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
                              child: CustomBackButton()),
                          Image.asset(
                            ImageConst.forgot,
                            // width: 70.h,
                            height: 168.h,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text(
                            "Create new password",
                            style: kBodyLargeSansBold,
                          ),
                          10.verticalSpace,
                          Text(
                            "Enter a new password to continue.",
                            style: kBodySmall.copyWith(color: textGrey),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          CustomTextField(
                            controller: forgetController.passController,
                            // validator: Utils.emailValidator,
                            hint: "New Password",
                            inputAction: TextInputAction.next,
                          ),
                          Spacer(),
                          CustomTextField(
                            controller: forgetController.confirmPassController,
                            // validator: Utils.emailValidator,
                            hint: "Confirm Password",
                            inputAction: TextInputAction.done,
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          CustomButton(
                            onTap: () {
                              if (forgetController.newPassFormkey!.currentState!
                                  .validate()) {
                                showSuccessSheet(
                                  title: "Congratulations",
                                  subtitle: "Your account is recover",
                                  buttonText: "Done",
                                  onTap: () {
                                    Get.offNamedUntil(AppRoutes.login, (route) => false);
                                  },
                                );
                              }
                            },
                            text: "Create Password",
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
      ),
    );
  }
}
