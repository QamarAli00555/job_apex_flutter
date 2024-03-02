import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/chat/create_chat.dart';
import '../../models/response/chat/get_chat.dart';
import '../../models/response/chat/intitial_msg.dart';
import '../config.dart';

class ChatHelper {
  static var client = https.Client();

  static Future<List<dynamic>> apply(CreateChat model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.chatsUrl}");
      var response = await https.post(url,
          headers: requestHeader, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
        var first = initialChatFromJson(response.body).id;
        return [true, first];
      } else {
        return [false];
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }

  static Future<List<GetChats>> getConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.chatsUrl}");

      var response = await https.get(url, headers: requestHeader);
      if (response.statusCode == 200) {
        var chats = getChatsFromJson(response.body);
        return chats;
      } else {
        throw Exception('Failed to get Chats');
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }
}
