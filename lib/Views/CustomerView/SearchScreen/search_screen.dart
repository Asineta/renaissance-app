import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/const.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_textfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        leading: true,
        gradient: true,
        title: "Search Course",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            10.verticalSpace,
            CustomTextField(
              hint: "Search",
              suffix: Icon(Icons.search),
            ),
          ]),
        ),
      ),
    );
  }
}
