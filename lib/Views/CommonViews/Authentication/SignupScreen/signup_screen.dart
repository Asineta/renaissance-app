import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/signup_controller.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';
import 'package:renaissance/Widgets/custom_textfield.dart';
import 'package:renaissance/Widgets/success_dialogue.dart';
import 'package:http/http.dart' as http;
import '../../../../Utils/utils.dart';
import '../../../../Widgets/custom_appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController retypePassController = TextEditingController();

  Future<void> signUpApi() async {
    var url = 'https://devu13.testdevlink.net/appAPI/signupSuccess.php';
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passController.text,
      'cpassword': retypePassController.text
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          showSuccessSheet(
            title: "Congratulations",
            subtitle: res['data'],
            buttonText: "Back to Login",
            onTap: () {
              Get.back();
              Get.back();
            },
          );
        } else {
          // throw Exception('Incorrect username or password try again.');
          setState(() {
            Fluttertoast.showToast(
                msg: res['data'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
      } else {
        throw Exception('Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GetBuilder(
            init: SignupController(),
            builder: (signupController) {
              return Form(
                key: signupController.signupFormKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.verticalSpace,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomBackButton()),
                      Text(
                        "Hello! Register to\nGet Started",
                        style: kBodyLargeSansBold,
                        textAlign: TextAlign.center,
                      ),
                      20.verticalSpace,
                      CustomTextField(
                        controller: nameController,
                        validator: Utils.nameValidator,
                        hint: "Full Name",
                        inputAction: TextInputAction.next,
                      ),
                      10.verticalSpace,
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: Utils.emailValidator,
                        hint: "Email",
                        inputAction: TextInputAction.next,
                      ),
                      // 10.verticalSpace,
                      // CustomTextField(
                      //   keyboardType: TextInputType.phone,
                      //   controller: phoneController,
                      //   // validator: Utils.emailValidator,
                      //   hint: "Phone Number",
                      //   inputAction: TextInputAction.next,
                      // ),
                      10.verticalSpace,
                      CustomTextField(
                        obscureText: signupController.isHide.value,
                        validator: Utils.passValidator,
                        controller: passController,
                        // validator: ,
                        hint: "Password",
                        inputAction: TextInputAction.next,

                        suffix: InkWell(
                          onTap: () {
                            signupController.setIsHide =
                                !signupController.isHide.value;
                          },
                          child: Icon(
                            signupController.isHide.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      CustomTextField(
                        obscureText: signupController.isConfirmHide.value,
                        validator: Utils.passValidator,
                        controller: retypePassController,
                        // validator: ,
                        hint: "Re-type Password",
                        inputAction: TextInputAction.next,

                        suffix: InkWell(
                          onTap: () {
                            signupController.setIsConfirmHide =
                                !signupController.isConfirmHide.value;
                          },
                          child: Icon(
                            signupController.isConfirmHide.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      // 10.verticalSpace,
                      // CustomTextField(
                      //   // validator: ,
                      //   hint: "Upload Registration ID",
                      //   inputAction: TextInputAction.done,
                      //   suffix: const Icon(
                      //     Icons.upload,
                      //   ),
                      // ),
                      30.verticalSpace,
                      CustomButton(
                        btnColor: btnGradient,
                        onTap: () {
                          if (signupController.signupFormKey!.currentState!
                              .validate()) {
                            signUpApi();
                          }
                        },
                        text: "Register",
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
