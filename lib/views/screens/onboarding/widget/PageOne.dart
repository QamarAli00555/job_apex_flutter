import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_apex/views/common/exports.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: hieght,
        color: Color(kDarkPurple.value),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Image.asset(
                fit: BoxFit.contain,
                'assets/images/page1.png',
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  ReusableText(
                      text: 'Find Your dream job',
                      style:
                          appStyle(30, Color(kLight.value), FontWeight.w500)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: Text(
                      'Unlock your career potential with personalized job matching tailored to your unique skills and expertise. Let us guide you towards your dream job, where your talents truly shine.',
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
