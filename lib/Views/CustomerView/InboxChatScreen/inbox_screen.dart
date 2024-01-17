import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';
import 'package:renaissance/Utils/image_const.dart';
import 'package:renaissance/Widgets/custom_textfield.dart';

import '../../../Widgets/custom_appbar.dart';
import 'chatting_screen.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  List<Map<String, dynamic>> chats = [
    {
      "image": ImageConst.photo,
      "name": "Therapist A",
      "message": "Thanks I really appreciate it",
      "read": false
    },
    {
      "image": "${ImageConst.photo2}",
      "name": "Therapist C",
      "message": "Let’s keep creating amazing things 😊",
      "read": false
    },
    {
      "image": "${ImageConst.photo3}",
      "name": "Therapist D",
      "message": "Mentioned you in their story",
      "read": true
    },
    {
      "image": "${ImageConst.photo4}",
      "name": "Therapist E",
      "message": "Hello, I like your designs. I am searching for ...",
      "read": true
    },
    {
      "image": "${ImageConst.photo5}",
      "name": "Therapist F",
      "message": "I hope best for your journey and hope to ...",
      "read": true
    },
    {
      "image": "${ImageConst.photo6}",
      "name": "Therapist G",
      "message": "Mentioned you in their story",
      "read": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(gradient: true, title: "Inbox"),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 0.w, vertical: verticalPadding),
          child: Column(
            children: [
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: CustomTextField(
                  hint: "Search",
                  suffix: const Icon(Icons.search),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(ChatScreen());
                      },
                      leading: ClipRRect(
                          child: Image.asset(
                        chats[index]["image"],
                        // height: 50.h,
                        // width: 50.h,
                        fit: BoxFit.cover,
                      )),
                      title: RichText(
                        text: TextSpan(
                          text: "${chats[index]["name"]}        ",
                          style: kBodySmallSansBold,
                          children: [
                            TextSpan(text: "2 m ago", style: kBodyLabel),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        "${chats[index]["message"]}",
                        style: kBodySmall.copyWith(color: Color(0xff000080)),
                      ),
                      trailing: chats[index]["read"]
                          ? Container(
                              width: 10.w,
                            )
                          : Container(
                              padding: EdgeInsets.all(8.h),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff000080)),
                              child: Text(
                                "2",
                                style: kBodyLabel.copyWith(
                                    color: white, fontSize: 12.sp),
                              ),
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
