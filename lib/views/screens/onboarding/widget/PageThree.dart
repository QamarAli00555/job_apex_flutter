import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_apex/views/common/custom_outline_btn.dart';
import 'package:job_apex/views/common/exports.dart';
import 'package:job_apex/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: hieght,
        color: Color(kLightBlue.value),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                fit: BoxFit.contain,
                'assets/images/page3.png',
              ),
              const SizedBox(height: 20),
              ReusableText(
                text: "Welcome to JOB APEX",
                style: appStyle(30, Color(kLight.value), FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                child: Text(
                  'Where career aspirations meet their highest peak. Elevate your professional journey with our comprehensive resources and expert guidance towards success.',
                  textAlign: TextAlign.center,
                  style: appStyle(13, Color(kLight.value), FontWeight.normal),
                ),
              ),
              const SizedBox(height: 15),
              CustomOutlineBtn(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('entrypoint', true);
                    Get.to(() => const Mainscreen());
                  },
                  hieght: hieght * 0.05,
                  width: width * 0.9,
                  text: "Continue as guest",
                  color: Color(kLight.value))
            ],
          ),
        ),
      ),
    );
  }
}
