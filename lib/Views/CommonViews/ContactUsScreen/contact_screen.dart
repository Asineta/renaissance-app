import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/login_controller.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Widgets/success_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/const.dart';
import '../../../Utils/utils.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_elevated_button.dart';
import '../../../Widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    super.key,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginController? loginController;

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

  Future<void> contactUs() async {
    var url = 'https://devu13.testdevlink.net/appAPI/contactUs.php';
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'message': messageController.text,
      'subject': subjectController.text,
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          showSuccessSheet(
              subtitle: "Message has been sent\nSuccessfully!",
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
          title: "Contact Us",
          leading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    Text("Name*", style: kBodySmallSansBold),
                    15.verticalSpace,
                    CustomTextField(
                      controller: nameController,
                      // initialValue: nameController.text,
                      validator: Utils.nameValidator,
                      hint: "Name",
                      readOnly: true,
                      inputAction: TextInputAction.next,
                    ),
                    30.verticalSpace,
                    Text("Email*", style: kBodySmallSansBold),
                    // 15.verticalSpace,
                    15.verticalSpace,
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      readOnly: true,
                      // initialValue: emailController.text,
                      validator: Utils.emailValidator,
                      hint: "Email",
                      inputAction: TextInputAction.next,
                    ),
                    30.verticalSpace,
                    Text("Subject*", style: kBodySmallSansBold),
                    15.verticalSpace,

                    CustomTextField(
                      // obscureText: signupController.isHide.value,
                      validator: Utils.subjectValidator,
                      controller: subjectController,
                      // validator: ,
                      hint: "Subject",
                      inputAction: TextInputAction.next,
                      // suffix: InkWell(
                      //   onTap: () {
                      //     signupController.setIsHide =
                      //         !signupController.isHide.value;
                      //   },
                      //   child: Icon(
                      //     signupController.isHide.value
                      //         ? Icons.visibility
                      //         : Icons.visibility_off,
                      //   ),
                      // ),
                    ),
                    30.verticalSpace,
                    Text("Message*", style: kBodySmallSansBold),
                    15.verticalSpace,
                    CustomTextField(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      maxline: 4,
                      validator: Utils.messageValidator,
                      controller: messageController,
                      // validator: Utils.validator,
                      hint: "Message...",
                      inputAction: TextInputAction.next,
                      // suffix: InkWell(
                      //   onTap: () {
                      //     signupController.setIsConfirmHide =
                      //         !signupController.isConfirmHide.value;
                      //   },
                      //   child: Icon(
                      //     signupController.isConfirmHide.value
                      //         ? Icons.visibility
                      //         : Icons.visibility_off,
                      //   ),
                      // ),
                    ),
                    60.verticalSpace,
                    CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            contactUs();
                          }

                          // showSuccessDialog(
                          //     buttonText: "Okay",
                          //     onTap: () {
                          //       Get.back();
                          //       Get.back();
                          //     });
                          // signupController.profileFormKey!.currentState!
                          //     .validate();
                        },
                        text: "Update"),
                    // 40.verticalSpace,
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
                    // 20.verticalSpace,
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
