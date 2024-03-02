import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_apex/views/common/custom_outline_btn.dart';
import 'package:job_apex/views/common/exports.dart';
import 'package:job_apex/views/common/height_spacer.dart';
import 'package:job_apex/views/screens/auth/login_page.dart';

import '../../common/styled_container.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return buildStyleContainer(
        context,
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(99.w),
              child: CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/premium-vector/remove-delete-social-account-profile-concept-isometric-vector-illustrations-banner_106788-3907.jpg?size=626&ext=jpg&ga=GA1.1.1391092918.1704647654&semt=ais',
                fit: BoxFit.cover,
                width: width * 0.8,
                height: hieght * 0.2,
              ),
            ),
            const HeightSpacer(size: 20),
            ReusableText(
              text: 'To access content please login',
              style: appStyle(12, Color(kDarkGrey.value), FontWeight.normal),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: CustomOutlineBtn(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  width: width,
                  hieght: 40.h,
                  text: 'Process to login',
                  color: Color(kOrange.value)),
            )
          ],
        ));
  }
}
