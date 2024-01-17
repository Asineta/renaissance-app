import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Routes/app_routes.dart';
import 'Utils/text_theme.dart';
import 'Utils/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) {
        return Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: AppRoutes.routes,
            initialRoute: AppRoutes.splash,
            smartManagement: SmartManagement.full,
            title: 'Renaissance',
            theme: ThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: textBlack,
                  ),
              primarySwatch: Colors.grey,
              useMaterial3: false,
              primaryColor: primary,
              scaffoldBackgroundColor: Colors.white,
              dialogBackgroundColor: primary,
              appBarTheme: AppBarTheme(
                elevation: 0,
                // foregroundColor: Colors.transparent,
                centerTitle: true,
                // color: Colors.transparent,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                  color: textBlack,
                ),
                titleTextStyle:
                    kBodyLargeSansBold.copyWith(color: white, fontSize: 25.sp),
                actionsIconTheme: IconThemeData(
                  color: white,
                ),
              ),
              iconTheme: IconThemeData(color: white),
              dividerColor: textBlack,
              indicatorColor: iconFieldColor,
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.only(left: 20.w),
                filled: true,
                fillColor: fillFieldColor,
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: textGrey,
                  fontFamily: sansReg,
                ),
                suffixIconColor: iconFieldColor,
                prefixIconColor: iconFieldColor,
                focusColor: textGrey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: borderFieldGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: borderFieldGrey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: borderFieldGrey)),
              ),
              listTileTheme: const ListTileThemeData(
                horizontalTitleGap: 8.0,
              ),
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStatePropertyAll(primary),
              ),
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 3,
              ),
              dividerTheme: DividerThemeData(
                thickness: 1,
                color: borderFieldGrey,
              ),
              fontFamily: sansReg,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(390.w, 59.h),
                  foregroundColor: white,
                  elevation: 0,
                  shadowColor: primary,
                  animationDuration: const Duration(milliseconds: 700),
                  backgroundColor: Colors.transparent,
                  alignment: Alignment.center,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: white,
                    fontFamily: sansBold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
