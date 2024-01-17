import 'dart:async';

import 'package:get/get.dart';

import '../Routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offNamed(AppRoutes.onBoard);
    });
    // isLogin();
  }
}
