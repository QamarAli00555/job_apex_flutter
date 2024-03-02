import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/BackBtn.dart';
import '../../common/app_bar.dart';
import 'widgets/popular_jobs_list.dart';

class PopularJobsListPage extends StatelessWidget {
  const PopularJobsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: const CustomAppBar(
            text: "Jobs",
            child: BackBtn(),
          ),
        ),
        body: const PopularJobsList(),
      ),
    );
  }
}
