import 'package:get/get.dart';

import '../Views/CommonViews/Authentication/ForgetPassword/forget_password.dart';
import '../Views/CommonViews/Authentication/LoginScreen/login_screen.dart';
import '../Views/CommonViews/Authentication/NewPasswordScreen/new_password.dart';
import '../Views/CommonViews/Authentication/SignupScreen/signup_screen.dart';
import '../Views/CommonViews/ChangePasswordScreen/change_password_screen.dart';
import '../Views/CommonViews/ContactUsScreen/contact_screen.dart';
import '../Views/CommonViews/IntroductionScreen/introduction_screen.dart';
import '../Views/CommonViews/NotificationScreen/notification_screen.dart';
import '../Views/CommonViews/OnBoardingScreen/onBoardings_screen.dart';
import '../Views/CommonViews/PrivacyPolicyScreen/privacy_policy_screen.dart';
import '../Views/CommonViews/ProfileScreen/edit_profile_screen.dart';
import '../Views/CommonViews/Splash/splash.dart';
import '../Views/CommonViews/Terms&ConditionScreen/term_condition_screen.dart';
import '../Views/CustomerView/CourseDetailScreen/course_detail_screen.dart';
import '../Views/CustomerView/CourseListScreen/course_list_screen.dart';
import '../Views/CustomerView/CustomerBottomBar/CustomBottomBarScreen.dart';
import '../Views/CustomerView/MyCourseDetailScreen/my_course_detail_screen.dart';
import '../Views/CustomerView/SearchScreen/search_screen.dart';
import '../Views/CustomerView/TestScreen/test_policy_screen.dart';
import '../Views/CustomerView/TestScreen/test_screen.dart';
import '../Views/StaffView/BottomNavigationScreen/bottom_navigation_screen.dart';

class AppRoutes {
  //splash
  static String splash = "/splash";

  //onboard
  static String onBoard = "/onBoard";

  //intro
  static String intro = "/intro";

  ///Authentication Routes
  static String signup = "/signup";
  static String login = "/login";
  static String forget = "/forget";
  static String newPassword = "/newPassword";

  /// Bottom bar
  static String bottomNav = "/bottom";

  //profile screens
  static String editProfile = "/editProfile";
  static String changePass = "/changePass";
  static String terms = "/terms";
  static String privacy = "/privacy";
  static String contact = "/contact";
  static String myCourseDetail = "/myCourseDetail";

  ///customer routes

  /// Customer Bottom bar
  static String customerBottomNav = "/customerBottomNav";
  static String customerHome = "/customerHome";

  // static String courseDetail = "/courseDetail";
  // static String myCourseDetail = "/myCourseDetail";
  static String testScreen = "/testScreen";
  static String courseList = "/courseList";
  static String searchCourse = "/searchCourse";
  static String testPolicy = "/testPolicy";
  static String courseDetail = "/courseDetail";
  static String notifications = "/notifications";
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: onBoard,
      page: () => const OnBoardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: intro,
      page: () => const IntroductionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: forget,
      page: () => const ForgetScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: newPassword,
      page: () => const NewPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: bottomNav,
      page: () => const BottomNavigationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: terms,
      page: () => const TermsAndConditionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: privacy,
      page: () => const PrivacyAndPolicy(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: contact,
      page: () => const ContactScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: changePass,
      page: () => const ChangePasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: customerBottomNav,
      page: () => const CustomerBottomScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: courseList,
      page: () => const CourseListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: searchCourse,
      page: () => const SearchScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: testScreen,
      page: () => TestScreen(
        courseId: null,
      ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: testPolicy,
      page: () => const TestPolicyScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    // GetPage(
    //   name: courseDetail,
    //   page: () => CourseDetailScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    // GetPage(
    //   name: myCourseDetail,
    //   page: () => MyCourseDetailScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 400),
    // ),
    GetPage(
      name: notifications,
      page: () => NotificationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
