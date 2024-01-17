import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TestController extends GetxController {
  PageController pageController = PageController();
  RxInt _currentIndex = 0.obs;

  RxInt get currentIndex => _currentIndex;

  set setCurrentIndex(ind) {
    _currentIndex.value = ind;
    update();
  }

  nextPage() {
    setCurrentIndex = currentIndex.value + 1;
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);

  }
}
