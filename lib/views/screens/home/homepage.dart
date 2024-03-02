import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/jobs_provider.dart';
import '../../../controllers/login_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/heading_widget.dart';
import '../../common/search.dart';
import '../auth/profile_page.dart';
import '../jobs/jobs_list_page.dart';
import '../jobs/widgets/popular_jobs.dart';
import '../jobs/widgets/recent_jobs.dart';
import '../search/widgets/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPrefs();
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      return RefreshIndicator(
        onRefresh: () async {
          jobsNotifier.getJobs();
          jobsNotifier.getRecentJobs();
          setState(() {});
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: CustomAppBar(
                  actions: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const ProfilePage(drawer: false));
                        // Get.to(() => const LoginPage());
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.h),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
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
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search \n Find & Apply',
                      style: appStyle(38, Color(kDark.value), FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SearchWidget(
                      onTap: () {
                        Get.to(() => const SearchPage());
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    HeadingWidget(
                      text: 'Popular Jobs',
                      onTap: () {
                        Get.to(() => const PopularJobsListPage());
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: const PopularJobs()),
                    SizedBox(
                      height: 20.h,
                    ),
                    HeadingWidget(
                      text: 'Recently Posted',
                      onTap: () {
                        Get.to(() => const PopularJobsListPage());
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: const RecentJobs()),
                  ],
                ),
              ),
            ))),
      );
    });
  }
}
