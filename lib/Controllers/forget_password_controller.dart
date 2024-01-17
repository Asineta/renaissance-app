import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController {
  GlobalKey<FormState>? formkey;
  GlobalKey<FormState>? newPassFormkey;
  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? confirmPassController;
  RxBool _remember = false.obs;
  RxBool _isHide = true.obs;
  RxBool _isConfirmHide = true.obs;

  RxBool get remember => _remember;

  set setRemember(bool val) {
    _remember.value = val;
    update();
  }

  RxBool get isHide => _isHide;

  set setIsHide(bool val) {
    _isHide.value = val;
    update();
  }
  RxBool get isConfirmHide => _isConfirmHide;

  set setIsConfirmHide(bool val) {
    _isConfirmHide.value = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    formkey = GlobalKey<FormState>();
    newPassFormkey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
  }
}
