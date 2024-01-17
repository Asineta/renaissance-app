import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt _currentIndex = 0.obs;

  RxInt get currentIndex => _currentIndex;

  set setCurrentIndex(int val) {
    _currentIndex.value = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
