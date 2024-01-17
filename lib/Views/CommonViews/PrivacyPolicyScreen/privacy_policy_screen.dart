import 'package:flutter/material.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';

import '../../../Utils/utils.dart';
import '../../../Widgets/custom_appbar.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: "Privacy Policy",
        leading: true,
        gradient: !Utils.isStaff(),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Collecting Personal Information. ",
                style: kBodyMediumSansBold,
              ),
              Text(
                '''
We may collect, store and use the following kinds of personal information:
Information about your computer and about your visits to and use of this website including your IP address, geographical location, browser type and version, operating system, referral source, length of visit, page views and website navigation paths;
Information that you provide to us when registering with our website including your name, phone number and email address;
Information that you provide to us for the purpose of subscribing to our email notifications and/or newsletters including your name and email address;
Any other personal information that you choose to send to us.
Before you disclose to us the personal information of another person, you must obtain that person’s consent to both the disclosure and the processing of that personal information in accordance with this policy..  Using Personal Information
''',
                style: kBodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
