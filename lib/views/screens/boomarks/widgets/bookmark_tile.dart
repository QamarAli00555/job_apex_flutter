import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_apex/views/screens/home/job_details.dart';

import '../../../../constants/app_constants.dart';
import '../../../../models/response/bookmarks/all_bookmarks.dart';
import '../../../common/app_style.dart';
import '../../../common/custom_outline_btn.dart';
import '../../../common/reusable_text.dart';
import '../../../common/width_spacer.dart';

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    super.key,
    this.onTap,
    required this.bookmark,
  });
  final Function()? onTap;
  final AllBookMarks bookmark;
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
                color: const Color(0x09000000),
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
                          backgroundImage: NetworkImage(bookmark.job.imageUrl),
                        ),
                        WidthSpacer(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                              text: bookmark.job.company,
                              style: appStyle(
                                  12, Color(kDark.value), FontWeight.w500),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: ReusableText(
                                text: bookmark.job.title,
                                style: appStyle(12, Color(kDarkGrey.value),
                                    FontWeight.w500),
                              ),
                            ),
                            ReusableText(
                              text:
                                  "${bookmark.job.salary} per ${bookmark.job.period}",
                              style: appStyle(
                                  12, Color(kDark.value), FontWeight.w500),
                            ),
                          ],
                        ),
                        // text == 'Popular'?
                        CustomOutlineBtn(
                            onTap: () => Get.to(() => JobDetails(
                                title: bookmark.job.title,
                                id: bookmark.job.id,
                                agentName: bookmark.job.agentName)),
                            width: 90.w,
                            hieght: 36.h,
                            text: 'View',
                            color: Color(kLightBlue.value))
                        //     : CustomOutlineBtn(
                        //         width: 90.w,
                        //         hieght: 36.h,
                        //         text: 'Apply',
                        //         color: Color(kLightBlue.value))
                      ],
                    ),
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
