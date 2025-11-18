import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile_11pplg1_05/db_helper/db_helper.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';
import 'package:pas_mobile_11pplg1_05/controller/store_controller.dart';
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
    } catch (e) {
      debugPrint('Failed load bookmarks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addBookmark(Store store) async {
    try {
      await DBHelper.instance.insertBookmark(store);
      bookmarks.removeWhere((s) => s.id == store.id);
      bookmarks.add(store);
      try {
        final sc = Get.find<StoreController>();
        sc.products.removeWhere((s) => s.id == store.id);
      } catch (_) {}

      Get.snackbar('Bookmark', 'Disimpan ke bookmark',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan bookmark: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> removeBookmark(int id) async {
    try {
      await DBHelper.instance.removeBookmark(id);
      bookmarks.removeWhere((s) => s.id == id);
      Get.snackbar('Bookmark', 'Dihapus dari bookmark',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus bookmark: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<bool> isBookmarked(int id) async {
    try {
      return await DBHelper.instance.isBookmarked(id);
    } catch (e) {
      debugPrint('isBookmarked error: $e');
      return bookmarks.any((s) => s.id == id);
    }
  }
  Future<bool> toggleBookmark(Store store, {bool navigateToBookmarks = false}) async {
    final exists = await DBHelper.instance.isBookmarked(store.id);
    if (exists) {
      await DBHelper.instance.removeBookmark(store.id);
      bookmarks.removeWhere((s) => s.id == store.id);

      try {
        final sc = Get.find<StoreController>();
        if (!sc.products.any((s) => s.id == store.id)) {
          sc.products.insert(0, store);
        }
      } catch (_) {}

      Get.snackbar('Bookmark', 'Dihapus dari bookmark',
          backgroundColor: Colors.green, colorText: Colors.white);
      return false;
    } else {
      await DBHelper.instance.insertBookmark(store);
      bookmarks.removeWhere((s) => s.id == store.id);
      bookmarks.add(store);

      try {
        final sc = Get.find<StoreController>();
        sc.products.removeWhere((s) => s.id == store.id);
      } catch (_) {}

      Get.snackbar('Bookmark', 'Disimpan ke bookmark',
          backgroundColor: Colors.green, colorText: Colors.white);

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