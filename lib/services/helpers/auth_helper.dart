import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/auth/login_res_model.dart';
import '../../models/response/auth/profile_model.dart';
import '../../models/response/auth/skills.dart';
import '../config.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(model) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.signupUrl}");
      var response = await https.post(url, headers: requestHeader, body: model);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(model) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.loginUrl}");
      var response = await https.post(url, headers: requestHeader, body: model);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = loginResponseModelFromJson(response.body);

        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('uid', user.uid);
        await prefs.setString('profile', user.profile);
        await prefs.setString('username', user.username);
        await prefs.setBool('loggedIn', true);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) throw Exception('No authenticatioon token provided');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.profileUrl}");

      var response = await https.get(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        var profile = profileResFromJson(response.body);
        return profile;
      }
      throw Exception('Unable to get Profile');
    } catch (e) {
      throw Exception('Unable to get Profile $e');
    }
  }

  static Future<List<Skills>> getSkills() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) throw Exception('No authenticatioon token provided');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}");
      var response = await https.get(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        var skills = skillsFromJson(response.body);
        return skills;
      }
      throw Exception('Unable to get Skills');
    } catch (e) {
      throw Exception('Unable to get Skills $e');
    }
  }

  static Future<bool> addSkills(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) throw Exception('No authenticatioon token provided');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}");
      var response = await https.post(url, headers: requestHeader, body: model);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteSkills(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) throw Exception('No authenticatioon token provided');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.skillsUrl}/$id");
      print(url);
      var response = await https.delete(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
