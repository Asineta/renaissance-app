import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/const.dart';
import '../../../Utils/utils.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_elevated_button.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../Widgets/success_dialogue.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    // Retrieve values from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');

    // Set initial values for name and email in the text controllers
    nameController.text = name ?? '';
    emailController.text = email ?? '';
  }

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? type = prefs.getString('type');
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/updateProfile.php';
    var data = {'name': nameController.text, 'user_id': userId, 'type': type};

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          prefs.setString('name', nameController.text);
          showSuccessSheet(
              height: 370.h,
              title: "Congratulations",
              subtitle: "Your Profile has been updated  successfully.",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.verticalSpace,
                  CustomTextField(
                    controller: nameController,
                    validator: Utils.nameValidator,
                    hint: "Gianna Alexa",
                    inputAction: TextInputAction.next,
                  ),
                  15.verticalSpace,
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: Utils.emailValidator,
                    hint: "Gianna@gmail.com",
                    readOnly: true,
                    inputAction: TextInputAction.next,
                  ),
                  // 15.verticalSpace,
                  // CustomTextField(
                  //   // obscureText: signupController.isHide.value,
                  //   // validator: Utils.passValidator,
                  //   controller: signupController.phoneController,
                  //   // validator: ,
                  //   hint: "000-123-4567",
                  //   inputAction: TextInputAction.next,
                  // ),
                  // 15.verticalSpace,
                  // CustomTextField(
                  //   // validator: Utils.passValidator,
                  //   controller: signupController.registrationId,
                  //   // validator: Utils.validator,
                  //   hint: "Registration ID",
                  //   inputAction: TextInputAction.next,
                  // ),
                  60.verticalSpace,
                  CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfile();
                        }
                      },
                      text: "Update"),
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
