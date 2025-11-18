import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile_11pplg1_05/db_helper/db_helper.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';
import 'package:pas_mobile_11pplg1_05/routes/routes.dart';

class BookmarkController extends GetxController {
  final bookmarks = <Store>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      isLoading.value = true;
      final list = await DBHelper.instance.getAllBookmarks();
      bookmarks.assignAll(list);
    } catch (_) {
      debugPrint('Failed load bookmarks');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addBookmark(Store store) async {
    try {
      await DBHelper.instance.insertBookmark(store);
      bookmarks.removeWhere((s) => s.id == store.id);
      bookmarks.add(store);
    } catch (e) {
      debugPrint('Error add bookmark: $e');
    }
  }

  Future<void> removeBookmark(int id) async {
    try {
      await DBHelper.instance.removeBookmark(id);
      bookmarks.removeWhere((s) => s.id == id);
    } catch (e) {
      debugPrint('Error remove bookmark: $e');
    }
  }

  Future<bool> isBookmarked(int id) async {
    try {
      return await DBHelper.instance.isBookmarked(id);
    } catch (_) {
      return bookmarks.any((s) => s.id == id);
    }
  }

  Future<bool> toggleBookmark(Store store, {bool navigateToBookmarks = false}) async {
    final exists = await DBHelper.instance.isBookmarked(store.id);

    if (exists) {
      await DBHelper.instance.removeBookmark(store.id);
      bookmarks.removeWhere((s) => s.id == store.id);
      return false;
    } else {
      await DBHelper.instance.insertBookmark(store);
      bookmarks.removeWhere((s) => s.id == store.id);
      bookmarks.add(store);

      if (navigateToBookmarks) {
        Get.offAllNamed(Approutes.boookmark);
      }
      return true;
    }
  }

  void openBookmarkPage() {
    Get.offAllNamed(Approutes.boookmark);
  }
}
