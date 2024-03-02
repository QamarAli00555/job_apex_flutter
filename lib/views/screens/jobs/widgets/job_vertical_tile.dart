import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_apex/constants/app_constants.dart';
import 'package:job_apex/views/common/app_style.dart';

import '../../../../models/response/jobs/jobs_response.dart';
import '../../../common/reusable_text.dart';
import '../../../common/width_spacer.dart';

class JobVerticalTile extends StatelessWidget {
  const JobVerticalTile({super.key, this.onTap, required this.job});
  final Function()? onTap;
  final JobsResponse job;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            height: hieght * 0.12,
            width: width,
            decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                borderRadius: BorderRadius.circular(9.w)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        WidthSpacer(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                              text: job.company,
                              style: appStyle(
                                  14, Color(kDark.value), FontWeight.w500),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: ReusableText(
                                text: job.title,
                                style: appStyle(12, Color(kDarkGrey.value),
                                    FontWeight.w500),
                              ),
                            ),
                            ReusableText(
                              text: "${job.salary} per ${job.period}",
                              style: appStyle(
                                  12, Color(kDark.value), FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: const Icon(Ionicons.chevron_forward),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
