import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/bookmarks/all_bookmarks.dart';
import '../../models/response/bookmarks/bookmark.dart';
import '../config.dart';

class BookMarkHelper {
  static var client = https.Client();

  static Future<BookMark> addBookmark(model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.bookmarkUrl}");
      var response = await https.post(url, headers: requestHeader, body: model);
      if (response.statusCode == 200) {
        var bookmark = bookMarkFromJson(response.body);
        return bookmark;
      } else {
        throw Exception('Failed to get Bookmark');
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }

  static Future<List<AllBookMarks>> getAllBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.bookmarkUrl}");
      var response = await https.get(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        var bookmarks = allBookMarksFromJson(response.body);
        return bookmarks;
      } else {
        throw Exception('Failed to get Bookmark');
      }
    } catch (e) {
      throw Exception('Failed to get Bookmark: $e');
    }
  }

  static Future<BookMark?> getBookmark(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) {
        return null;
      }
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      var url = Uri.parse("${Config.apiUrl}${Config.singleBookmarkUrl}$jobId");
      var response = await https.get(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        var bookmark = bookMarkFromJson(response.body);
        return bookmark;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteBookmark(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token = prefs.getString('token');
      if (token == null) return false;
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };
      // var url = Uri.parse("${Config.apiUrl}${Config.jobs}");
      var url = Uri.parse("${Config.apiUrl}${Config.bookmarkUrl}/$jobId");
      var response = await https.delete(
        url,
        headers: requestHeader,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
