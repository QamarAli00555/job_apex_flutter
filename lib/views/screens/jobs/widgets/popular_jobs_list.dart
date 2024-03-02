import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_apex/views/screens/home/job_details.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_constants.dart';
import '../../../../controllers/jobs_provider.dart';
import '../../../../models/response/jobs/jobs_response.dart';
import '../../../common/pages_loader.dart';
import '../../../common/styled_container.dart';
import 'uploaded_tile.dart';

class PopularJobsList extends StatelessWidget {
  const PopularJobsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJobs();
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: buildStyleContainer(
            context,
            SizedBox(
              height: hieght * 0.28,
              child: FutureBuilder<List<JobsResponse>>(
                future: jobsNotifier.jobList,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PageLoader();
                  } else if (snapshot.hasError) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      alignment: Alignment.center,
                      width: width,
                      height: hieght * 0.3,
                      child: Image.asset("assets/images/optimized_search.png"),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No Jobs Found'),
                      ],
                    );
                  } else {
                    final jobs = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: jobs!.length,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return UploadedTile(
                          onTap: () => Get.to(() => JobDetails(
                              title: job.title,
                              id: job.id,
                              agentName: job.agentName)),
                          job: job,
                          text: "Popular",
                        );
                      },
                    );
                  }
                }),
              ),
            )),
      );
    });
  }
}
