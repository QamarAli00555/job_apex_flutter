import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_constants.dart';
import '../../../../controllers/jobs_provider.dart';
import '../../../../models/response/jobs/jobs_response.dart';
import '../../../common/pages_loader.dart';
import '../../../common/styled_container.dart';
import '../../home/job_details.dart';
import 'job_vertical_tile.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJobs();
      return buildStyleContainer(
          context,
          SizedBox(
            height: hieght * 0.28,
            child: FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.jobList,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
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
                      return JobVerticalTile(
                        job: job,
                        onTap: () {
                          Get.to(() => JobDetails(
                                id: job.id,
                                title: job.title,
                                agentName: job.agentName,
                              ));
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ));
    });
  }
}
