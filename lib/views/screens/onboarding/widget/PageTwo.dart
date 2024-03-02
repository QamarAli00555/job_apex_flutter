import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: hieght,
        color: Color(kDarkBlue.value),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                fit: BoxFit.contain,
                'assets/images/page2.png',
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    "Stable Yourself \n With Tour Abilities",
                    style: appStyle(30, Color(kLight.value), FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: Text(
                      'Ground yourself with confidence, anchored by the strength of your abilities. Embrace stability as you navigate towards success with unwavering determination.',
                      textAlign: TextAlign.center,
                      style:
                          appStyle(13, Color(kLight.value), FontWeight.normal),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
