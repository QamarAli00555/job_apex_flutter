import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_apex/constants/app_constants.dart';
import 'package:job_apex/views/common/custom_textfield.dart';

class AddSkillsWidget extends StatelessWidget {
  final TextEditingController userSkill;
  final void Function()? onTap;
  const AddSkillsWidget({super.key, required this.userSkill, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      height: 62.w,
      child: CustomTextField(
        borderDecoration: true,
        controller: userSkill,
        hintText: 'Add New Skill',
        keyboardType: TextInputType.text,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: const Icon(
            Entypo.upload_to_cloud,
            size: 30,
            color: kNewBlue,
          ),
        ),
        validator: (input) {
          if (input!.isEmpty) {
            return "Please enter skill name";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
