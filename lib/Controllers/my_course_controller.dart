import 'package:get/get.dart';

class CourseListController extends GetxController {
  RxInt _currentIndex = 0.obs;

  RxInt get currentIndex => _currentIndex;

  set setCurrentIndex(ind) {
    _currentIndex.value = ind;
    update();
  }
}
