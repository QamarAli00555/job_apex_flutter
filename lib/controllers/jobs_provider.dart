import 'package:flutter/material.dart';
import 'package:job_apex/models/response/jobs/get_job.dart';
import 'package:job_apex/models/response/jobs/jobs_response.dart';
import 'package:job_apex/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<List<JobsResponse>> recentJobsList;
  late Future<GetJobRes>? job;

  Future<List<JobsResponse>> getJobs() async {
    jobList = JobsHelper.getJobs();
    return jobList;
  }

  Future<GetJobRes> getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
    return job!;
  }

  Future<List<JobsResponse>> getRecentJobs() {
    recentJobsList = JobsHelper.getRecentJobs();
    return recentJobsList;
  }
}
