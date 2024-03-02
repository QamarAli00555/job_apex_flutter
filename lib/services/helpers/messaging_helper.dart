import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_apex/models/response/messaging/messaging_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/messaging/send_message.dart';
import '../config.dart';

class MessagingHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.messagingUrl}");
      var response = await https.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        ReceivedMessge message =
            ReceivedMessge.fromJson(jsonDecode(response.body));
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return [true, message, responseMap];
      } else {
        return [false];
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }

  static Future<List<ReceivedMessge>> getMessages(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.messagingUrl}");
      var response = await https.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var messages = receivedMessgeFromJson(response.body);
        return messages;
      } else {
        throw Exception('Failed to get Messages');
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }
}
