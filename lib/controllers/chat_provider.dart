import 'package:flutter/material.dart';
import 'package:job_apex/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/chat/get_chat.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;

  String? _userId;

  String get userId => _userId ?? '';
  set setUserId(String newState) {
    _userId = newState;
    notifyListeners();
  }

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('uid') ?? '';
  }
}
