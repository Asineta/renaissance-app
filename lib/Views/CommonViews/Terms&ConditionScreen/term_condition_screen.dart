import 'package:flutter/material.dart';
import 'package:renaissance/Utils/text_theme.dart';
import 'package:renaissance/Utils/const.dart';

import '../../../Utils/utils.dart';
import '../../../Widgets/custom_appbar.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        gradient: !Utils.isStaff(),

        title: "Terms & Condition",
        leading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our website uses cookies. ",
                style: kBodyMediumSansBold,
              ),
              Text(
                '''
A cookie is a file containing an identifier (a string of letters and numbers) that is sent by a web server to a web browser and is stored by the browser. The identifier is then sent back to the server each time the browser requests a page from the server. 
Cookies may be either “persistent” cookies or “session” cookies: a persistent cookie will be stored by a web browser and will remain valid until its set expiry date, unless deleted by the user before the expiry date; a session cookie, on the other hand, will expire at the end of the user session, when the web browser is closed.
Cookies do not typically contain any information that personally identifies a user, but personal information that we store about you may be linked to the information stored in and obtained from cookies. 
We use may use both session and persistent cookies on our website.The names of the cookies that we use on our website, and the purposes for which they are used, are set out below:''',
                style: kBodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
