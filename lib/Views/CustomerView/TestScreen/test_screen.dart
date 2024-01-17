// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:renaissance/Controllers/test_controller.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Views/CustomerView/MyCourseDetailScreen/my_course_detail_screen.dart';
import 'package:renaissance/Widgets/custom_elevated_button.dart';
import 'package:renaissance/Widgets/success_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/const.dart';
import '../../../Widgets/custom_appbar.dart';

class TestScreen extends StatefulWidget {
  var courseId;
  TestScreen({super.key, required this.courseId});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var totalAnswers = 0;
  var totalQuestions = 0;
  List<String?> selectedOptions = [];
  List<String> correctAnswers = [];
  TestController controller = TestController();

  List<dynamic> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions().then((fetchedQuestions) {
      setState(() {
        questions = fetchedQuestions;
        selectedOptions = List<String?>.filled(questions.length, null);
        correctAnswers = questions.map<String>((q) => q['correct']).toList();
        totalAnswers = 0;
        totalQuestions = 0;
        isLoading = false;
      });
    });
  }

  Future<List<dynamic>> fetchQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var url = 'https://devu13.testdevlink.net/appAPI/courseTest.php';
    var data = {
      'course_id': widget.courseId,
      'user_id': userId,
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      if (res['error'] == "false") {
        print(res['data']);
        return res['data'];
      } else {
        throw Exception('Failed to load courses detail');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load courses detail');
    }
  }

  Future<void> completeCourse() async {
    var url = 'https://devu13.testdevlink.net/appAPI/completeCourse.php';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {
      'user_id': userId,
      'course_id': widget.courseId,
    };

    try {
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if (res['error'] == "false") {
          showSuccessSheet(
            subtitle: "Congratulations, The course has been completed.",
            buttonText: "Okay",
            onTap: () {
              Get.off(() => MyCourseDetailScreen(courseId: widget.courseId));
            },
          );
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
    print(totalQuestions);
    return Scaffold(
      appBar: buildCustomAppBar(
        leading: true,
        gradient: true,
        title: "Test ",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: GetBuilder(
            init: controller,
            builder: (_) {
              return isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        PageView.builder(
                          controller: controller.pageController,
                          itemCount: questions.length, // Use the length of data
                          onPageChanged: (i) {
                            // print(i);
                            controller.setCurrentIndex = i;
                          },
                          itemBuilder: (context, ind) {
                            if (questions.isNotEmpty) {
                              var currentQuestion = questions[ind];
                              return QuestionWidget(
                                question: currentQuestion['question'],
                                options: currentQuestion['options'],
                                index: ind,
                                onOptionSelected: (selected) {
                                  selectedOptions[ind] = selected;
                                },
                              );
                            } else {
                              return const Center(child: Text('No Data Found'));
                            }
                          },
                        ),
                        totalQuestions == 9
                            ? Positioned(
                                right: 0,
                                bottom: 10.h,
                                child: CustomButton(
                                  onTap: () {
                                    var currentIndex =
                                        controller.pageController.page!.round();
                                    var selectedOption =
                                        selectedOptions[currentIndex];
                                    var correctOption =
                                        correctAnswers[currentIndex];

                                    totalQuestions++;
                                    if (selectedOption == correctOption) {
                                      // print("Correct Answer!");
                                      totalAnswers++;
                                    } else {
                                      // print(
                                      //     "Incorrect Answer. Correct is: $correctOption");
                                    }

                                    if (totalAnswers < 7) {
                                      setState(() {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You didn't Pass the test. Your score is ${totalAnswers} out of ${totalQuestions}. Please Try Again",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      });
                                      Future.delayed(const Duration(seconds: 3))
                                          .then((value) {
                                        Get.off(() => MyCourseDetailScreen(
                                            courseId: widget.courseId));
                                      });
                                    } else {
                                      completeCourse();
                                    }
                                  },
                                  text: "Submit",
                                ),
                              )
                            : Positioned(
                                right: 0,
                                bottom: 10.h,
                                child: CustomButton(
                                  width: 110.w,
                                  deco: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: const Color(0xff092eda)),
                                  onTap: () {
                                    var currentIndex =
                                        controller.pageController.page!.round();
                                    var selectedOption =
                                        selectedOptions[currentIndex];
                                    var correctOption =
                                        correctAnswers[currentIndex];
                                    if (currentIndex < questions.length - 1) {
                                      controller.nextPage();
                                    }

                                    totalQuestions++;
                                    if (selectedOption == correctOption) {
                                      // print("Correct Answer!");
                                      totalAnswers++;
                                    } else {
                                      // print(
                                      //     "Incorrect Answer. Correct is: $correctOption");
                                    }
                                    print(totalAnswers);

                                    // controller.pageController.nextPage(
                                    //   duration: Duration(milliseconds: 300),
                                    //   curve: Curves.easeInOut,
                                    // );
                                  },
                                  text: "Next",
                                ),
                              ),
                      ],
                    );
            }),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final String question;
  final List<dynamic> options;
  final Function(String?) onOptionSelected;
  var index;

  QuestionWidget(
      {Key? key,
      required this.question,
      required this.options,
      required this.onOptionSelected,
      required this.index})
      : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.verticalSpace,
            Text(
              "Question ${widget.index + 1}",
              style: kBodyMedium.copyWith(color: textGrey),
            ),
            8.verticalSpace,
            Text(widget.question, style: kBodyMedium.copyWith(color: textGrey)),
          ],
        ),
        12.verticalSpace,
        ...widget.options.map((option) {
          return Container(
            alignment: Alignment.center,
            height: 70.h, // Adjust the height as per your design
            margin: EdgeInsets.only(bottom: 15.h),
            width: 1.sw, // Full screen width
            padding: EdgeInsets.only(
                left: 10.w, top: 3.h, bottom: 10.h, right: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xffE4E4E4),
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  _selectedOption = value;
                  widget.onOptionSelected(
                      value); // Update the selected option in parent
                });
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
