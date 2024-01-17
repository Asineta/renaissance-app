import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/login_controller.dart';
import 'package:renaissance/Routes/app_routes.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/utils.dart';
import 'package:renaissance/Widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Widgets/custom_elevated_button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // LoginController? loginController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // *****User Login*****//
  Future<void> userLogin() async {
    var url = 'https://devu13.testdevlink.net/appAPI/userLogin.php';
    var data = {
      'email': emailController.text,
      'password': passController.text,
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('loggedIn', true);
          prefs.setString('type', 'user');
          prefs.setInt('user_id', res['data']['user_id']);
          prefs.setString('name', res['data']['name']);
          prefs.setString('email', res['data']['email']);
          prefs.setInt('status', res['data']['status']);
          prefs.setString('profile_pic', res['data']['profile_pic']);
          // Set the lastLoginTimestamp to the current time
          int? currentTimestamp = DateTime.now().millisecondsSinceEpoch;
          prefs.setInt('lastLoginTimestamp', currentTimestamp);
          print(prefs.setInt('lastLoginTimestamp', currentTimestamp));
          Get.offAllNamed(AppRoutes.customerBottomNav, arguments: {
            'name': res['data']['name'],
            'email': res['data']['email'],
          });
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

// *****Staff Login*****//
  Future<void> staffLogin() async {
    var url = 'https://devu13.testdevlink.net/appAPI/staffLogin.php';
    var data = {
      'email': emailController.text,
      'password': passController.text,
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('loggedIn', true);
          prefs.setString('type', 'staff');
          prefs.setInt('user_id', res['data']['staff_id']);
          prefs.setString('name', res['data']['name']);
          prefs.setString('email', res['data']['email']);
          prefs.setInt('status', res['data']['status']);
          prefs.setString('profile_pic', res['data']['profile_pic']);
          // Set the lastLoginTimestamp to the current time
          int? currentTimestamp = DateTime.now().millisecondsSinceEpoch;
          prefs.setInt('lastLoginTimestamp', currentTimestamp);
          print(prefs.setInt('lastLoginTimestamp', currentTimestamp));
          Get.offAllNamed(AppRoutes.bottomNav);
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

  void checkLoginStatus() async {
    print("Checking login status");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('loggedIn');
    String? type = prefs.getString('type');
    if (isLoggedIn != null && isLoggedIn) {
      int? lastLoginTimestamp = prefs.getInt('lastLoginTimestamp');

      if (lastLoginTimestamp != null) {
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        int timeDifferenceInHours =
            (currentTimestamp - lastLoginTimestamp) ~/ (1000 * 60 * 60);

        if (timeDifferenceInHours < 24) {
          // print("Already logged in, navigating to HomeScreen");
          if (type == "user") {
            Get.offAllNamed(AppRoutes.customerBottomNav);
          } else {
            Get.offAllNamed(AppRoutes.bottomNav);
          }
        } else {
          prefs.setBool('loggedIn', false);
          print("Session expired, please log in again.");
        }
      } else {
        prefs.setBool('loggedIn', false);
        print("Session data corrupted, please log in again.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: DefaultTabController(
            length: 2,
            child: GetBuilder(
                init: LoginController(),
                builder: (loginController) {
                  return Form(
                    key: loginController.signinFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        ClipRRect(
                          child: Image.asset(
                            ('assets/images/icon.png'),
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                        5.verticalSpace,
                        Text(
                          "Let's Sign you In",
                          style: kBodyLargeSansBold,
                        ),
                        5.verticalSpace,
                        Text(
                          "Welcome back you’ve been missed!!",
                          style: kBodySmall.copyWith(color: textGrey),
                        ),
                        20.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      loginController.staff.value == true
                                          ? primary
                                          : Colors.grey.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  loginController.staff.value = true;
                                  loginController.update();
                                },
                                child: const Text('Staff'),
                              ),
                            ),
                            15.horizontalSpace,
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      loginController.staff.value == false
                                          ? primary
                                          : Colors.grey.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  loginController.setStaff = false;
                                  loginController.update();
                                },
                                child: const Text(
                                  'Member',
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          controller: emailController,
                          validator: Utils.emailValidator,
                          hint: "Enter your email",
                          inputAction: TextInputAction.next,
                        ),
                        10.verticalSpace,
                        CustomTextField(
                          obscureText: loginController.isHide.value,
                          validator: Utils.passValidator,
                          controller: passController,
                          // validator: ,
                          hint: "Enter your password",
                          inputAction: TextInputAction.done,
                          suffix: InkWell(
                            onTap: () {
                              loginController.setIsHide =
                                  !loginController.isHide.value;
                            },
                            child: Icon(
                              loginController.isHide.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Checkbox(
                        //         side: BorderSide(
                        //           color: iconFieldColor,
                        //         ),
                        //         shape: RoundedRectangleBorder(
                        //           side: BorderSide(
                        //             color: iconFieldColor,
                        //           ),
                        //         ),
                        //         // fillColor:
                        //         //     MaterialStatePropertyAll<Color>(fillFieldColor),
                        //         checkColor: iconFieldColor,
                        //         activeColor: textGrey.withOpacity(0.1),
                        //         value: loginController.staff.value,
                        //         onChanged: (val) {
                        //           loginController.setStaff = val!;
                        //         }),
                        //     Text(
                        //       "Login As Staff Member",
                        //       style: kBodyLabel,
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    side: BorderSide(
                                      color: iconFieldColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: iconFieldColor,
                                      ),
                                    ),
                                    // fillColor:
                                    //     MaterialStatePropertyAll<Color>(fillFieldColor),
                                    checkColor: iconFieldColor,
                                    activeColor: textGrey.withOpacity(0.1),
                                    value: loginController.remember.value,
                                    onChanged: (val) {
                                      loginController.setRemember = val!;
                                    }),
                                Text(
                                  "Remember me",
                                  style: kBodyLabel,
                                ),
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.toNamed(AppRoutes.forget);
                            //   },
                            //   child: Text(
                            //     "Forgot Password?",
                            //     style: kBodySmallSansBold.copyWith(
                            //         color: textGrey),
                            //   ),
                            // )
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        CustomButton(
                          btnColor: btnGradient,
                          onTap: () {
                            if (loginController.signinFormKey!.currentState!
                                .validate()) {
                              Utils.setStaff(loginController.staff.value);
                              if (loginController.staff.value) {
                                staffLogin();
                              } else {
                                userLogin();
                              }
                            }
                          },
                          text: "Login",
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       // width: 160.w,
                        //       child: Divider(
                        //         color: textGrey,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 7.w),
                        //       child: Text(
                        //         'Or Login with',
                        //         style: kBodyLabel,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       // width: 160.w,
                        //       child: Divider(
                        //         color: textGrey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Spacer(
                        //   flex: 1,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 15.h, horizontal: 30.w),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50.r),
                        //           border: Border.all(color: borderFieldGrey)),
                        //       child: Icon(
                        //         Icons.facebook_sharp,
                        //         color: Colors.blue,
                        //         size: 30.sp,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 15.h, horizontal: 30.w),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50.r),
                        //           border: Border.all(color: borderFieldGrey)),
                        //       child: Image.asset(
                        //         ImageConst.google,
                        //         height: 26.h,
                        //         width: 26.w,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 15.h, horizontal: 30.w),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50.r),
                        //           border: Border.all(color: borderFieldGrey)),
                        //       child: Image.asset(
                        //         ImageConst.apple,
                        //         height: 26.h,
                        //         width: 26.w,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Spacer(
                        //   flex: 3,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.signup);
                              },
                              child: Text(
                                "Register Now",
                                style:
                                    kBodySmallSansBold.copyWith(color: primary),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
