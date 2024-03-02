import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/reusable_text.dart';
import '../auth/non_user.dart';
import '../auth/profile_page.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomAppBar(
              actions: [
                InkWell(
                  onTap: () {
                    Get.to(() => const ProfilePage(drawer: false));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: CachedNetworkImage(
                        height: 35.w,
                        width: 35.w,
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://img.freepik.com/free-photo/close-up-portrait-caucasian-unshaved-man-eyeglasses-looking-camera-with-sincere-smile-isolated-gray_171337-630.jpg?size=626&ext=jpg&ga=GA1.1.1391092918.1704647654&semt=ais',
                      ),
                    ),
                  ),
                )
              ],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: DrawerWidget(color: Color(kDark.value)),
              )),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Center(
                child: ReusableText(
                    text: "Applied Jobs",
                    style: appStyle(18, Color(kDark.value), FontWeight.bold)),
              ));
  }
}
