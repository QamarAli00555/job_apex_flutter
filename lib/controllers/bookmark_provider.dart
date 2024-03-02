import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../models/response/bookmarks/all_bookmarks.dart';
import '../services/helpers/book_helper.dart';

class BookNotifier extends ChangeNotifier {
  late Future<List<AllBookMarks>> bookmarks;

  bool _bookmark = false;
  bool get bookmark => _bookmark;
  set isBookMark(bool newState) {
    if (_bookmark != newState) {
      _bookmark = newState;
      notifyListeners();
    }
  }

  String _bookmarkId = '';
  String get bookmarkId => _bookmarkId;
  set isBookMarkId(String newState) {
    if (_bookmarkId != newState) {
      _bookmarkId = newState;
      notifyListeners();
    }
  }

  addBookmark(String model) {
    BookMarkHelper.addBookmark(model).then((bookmark) {
      isBookMark = bookmark.status;
      isBookMarkId = bookmark.bookmarkId;
    });
  }

  getBookmark(String jobId) {
    var bookmark = BookMarkHelper.getBookmark(jobId);

    bookmark.then((bookmark) {
      if (bookmark == null) {
        isBookMark = false;
        isBookMarkId = '';
      } else {
        isBookMark = bookmark.status;
        isBookMarkId = bookmark.bookmarkId;
      }
    });
  }

  deleteBookmark(String jobId) {
    BookMarkHelper.deleteBookmark(jobId).then((resopse) {
      if (resopse == true) {
        Get.snackbar('Bookmark Successfully deleted',
            'Visit the bookmarks page to see the changes',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
      isBookMark = false;
    });
  }

  Future<List<AllBookMarks>> getBookmarks() {
    bookmarks = BookMarkHelper.getAllBookmarks();

    return bookmarks;
  }
}
