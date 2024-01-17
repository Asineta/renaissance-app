import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  late GlobalKey<FormState> profileFormKey;
  GlobalKey<FormState>? passFormKey;
  TextEditingController? emailController;
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? currentPassController;

  TextEditingController? passController;
  TextEditingController? confirmPassController;
  TextEditingController? registrationId;

  RxBool _remember = false.obs;
  RxBool _isHide = true.obs;
  RxBool _isCurrentHide = true.obs;
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

  RxBool get isCurrentHide => _isCurrentHide;

  set setIsCurrentHide(bool val) {
    _isCurrentHide.value = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    profileFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    currentPassController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    registrationId = TextEditingController();
  }
}
