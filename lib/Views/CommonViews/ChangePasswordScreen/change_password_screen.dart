import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/utils.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';
import 'package:renaissance/Widgets/success_dialogue.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/text_theme.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureCurrentPass = true;
  bool _obscureNewPass = true;
  bool _obscureConfirmPass = true;

// Toggles the password show status for the specified field
  void _toggle(String field) {
    setState(() {
      switch (field) {
        case "currentPass":
          _obscureCurrentPass = !_obscureCurrentPass;
          break;
        case "newPass":
          _obscureNewPass = !_obscureNewPass;
          break;
        case "confirmPass":
          _obscureConfirmPass = !_obscureConfirmPass;
          break;
      }
    });
  }

  Future<void> changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? type = prefs.getString('type');
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/changePassword.php';
    var data = {
      'oldPassword': currentPassController.text,
      'password': newPassController.text,
      'confirmpassword': confirmPassController.text,
      'user_id': userId,
      'type': type
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          showSuccessSheet(
              height: 370.h,
              title: "Congratulations",
              subtitle: "Your password has been changed  successfully.",
              buttonText: "Okay",
              onTap: () {
                Get.back();
                Get.back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: !Utils.isStaff(),
        leading: true,
        title: "Edit Profile",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text("Current Password*", style: kBodyMedium),
                  15.verticalSpace,
                  CustomTextField(
                    obscureText: _obscureCurrentPass,
                    controller: currentPassController,
                    validator: Utils.passValidator,
                    hint: "Current Password",
                    inputAction: TextInputAction.next,
                    suffix: InkWell(
                      onTap: () => _toggle("currentPass"),
                      child: Icon(
                        _obscureCurrentPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  Text("New Password*", style: kBodyMedium),
                  15.verticalSpace,
                  CustomTextField(
                    obscureText: _obscureNewPass,
                    validator: Utils.passValidator,
                    controller: newPassController,
                    // validator: ,
                    hint: "New Password",
                    inputAction: TextInputAction.next,
                    suffix: InkWell(
                      onTap: () => _toggle("newPass"),
                      child: Icon(
                        _obscureNewPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  Text("Confirm New password*", style: kBodyMedium),
                  15.verticalSpace,
                  CustomTextField(
                    obscureText: _obscureConfirmPass,
                    validator: Utils.passValidator,
                    controller: confirmPassController,
                    // validator: ,
                    hint: "Confirm new password",
                    inputAction: TextInputAction.next,
                    suffix: InkWell(
                      onTap: () => _toggle("confirmPass"),
                      child: Icon(
                        _obscureConfirmPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  60.verticalSpace,
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          changePassword();
                        });
                      }
                    },
                    text: "Update",
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
