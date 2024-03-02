import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/custom_textfield.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onTap;
  const CustomField({super.key, this.onTap, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      color: Color(kLightGrey.value),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Ionicons.chevron_back_circle,
                  size: 30.h,
                  color: Color(kOrange.value),
                )),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(top: 20.h),
            width: width * 0.5,
            child: CustomTextField(
              onChanged: (val) => onTap,
              controller: controller,
              hintText: 'Search',
              keyboardType: TextInputType.text,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.search_circle_outline,
                  size: 30.h,
                  color: Color(kOrange.value),
                )),
          ),
        ],
      ),
    );
  }
}
