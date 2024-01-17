import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Widgets/custom_textfield.dart';

import '../../../Widgets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  List<Map<String, dynamic>> chats = [
    {
      "me": false,
      "message":
          "Hi David I saw your work and really am a big fan of your design",
    },
    {
      "me": true,
      "message": "Thank you! 😊",
    },
    {
      "me": false,
      "message": "Are you free for UI work?",
    },
    {
      "me": true,
      "message": "I have no availability before September",
    },
    {
      "me": false,
      "message": "We need some urgent basis\nThanks",
    },
    {
      "me": true,
      "message": "Maybe for a next project alors!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(gradient: true, title: "Chat", leading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: Column(
            children: [
              20.verticalSpace,
              Text(
                "Thursday 12:40 AM",
                style: kBodyLabel,
              ),
              20.verticalSpace,
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: chats[index]["me"]
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              margin: chats[index]["me"]
                                  ? EdgeInsets.only(left: 50.w, bottom: 20.h)
                                  : EdgeInsets.only(right: 50.w, bottom: 20.h),
                              decoration: BoxDecoration(
                                borderRadius: chats[index]["me"]
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(
                                          15.r,
                                        ),
                                        bottomRight: Radius.circular(15.r),
                                        bottomLeft: Radius.circular(15.r),
                                      )
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(
                                          15.r,
                                        ),
                                        topRight: Radius.circular(
                                          15.r,
                                        ),
                                        bottomRight: Radius.circular(
                                          15.r,
                                        ),
                                      ),
                                color: chats[index]["me"]
                                    ? Colors.lightBlue
                                    : hintColor.withOpacity(0.2),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Text(
                                "${chats[index]["message"]}",
                                style: kBodySmall.copyWith(
                                    color: chats[index]["me"]
                                        ? Colors.white
                                        : textBlack),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomTextField(
          hint: "Message",
          suffix: const Icon(Icons.send),
        ),
      ),
    );
  }
}
