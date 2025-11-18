import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var className = ''.obs;

  var isMobile = true.obs;

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Guest';
    className.value = prefs.getString('class') ?? '11 PPLG 1';
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.snackbar(
      'Logout berhasil',
      'Sampai jumpa lagi!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Color(0xFFFFFFFF),
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(12),
      borderRadius: 10,
    );
    await Future.delayed(const Duration(milliseconds: 800));
    Get.offAllNamed(Approutes.login);
  }
}
