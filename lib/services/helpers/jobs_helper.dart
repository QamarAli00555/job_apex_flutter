import 'package:http/http.dart' as https;
import 'package:job_apex/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/jobs/get_job.dart';
import '../../models/response/jobs/jobs_response.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<bool> createJob(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) {
        return false;
      }
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var response = await https.post(url, headers: requestHeader, body: model);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateJob(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) {
        return false;
      }
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var response = await https.put(url, headers: requestHeader, body: model);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<JobsResponse>> getJobs() async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var response = await https.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var jobList = jobsResponseFromJson(response.body);
        return jobList;
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Unable to load jobs');
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse("${Config.apiUrl}${Config.jobs}/$jobId");

      var response = await client.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var job = getJobResFromJson(response.body);
        return job;
      } else {
        throw Exception('Failed to load job');
      }
    } catch (e) {
      throw Exception('Failed to load job');
    }
  }

  static Future<List<JobsResponse>> getRecentJobs() async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.jobs}?new=true");
      // print(url);
      var response = await https.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var jobList = jobsResponseFromJson(response.body);
        return jobList;
      } else {
        throw Exception('Failed to load recent jobs');
      }
    } catch (e) {
      throw Exception('Unable to load recent jobs');
    }
  }

  static Future<List<JobsResponse>> searchJobs(String query) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.search}/$query");
      // print(url);
      var response = await https.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var jobList = jobsResponseFromJson(response.body);
        return jobList;
      } else {
        throw Exception('Failed to load recent jobs');
      }
    } catch (e) {
      throw Exception('Unable to load recent jobs');
    }
  }
}
