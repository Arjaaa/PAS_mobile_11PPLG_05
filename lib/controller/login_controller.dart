import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/routes.dart';
import '../network/client_network_login.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var username = ''.obs;
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

   var isMobile = true.obs;

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username');

    if (name != null && name.isNotEmpty) {
      username.value = name;
      isLoggedIn.value = true;
      Get.offAllNamed(Approutes.home); 
    } else {
      isLoggedIn.value = false;
      Get.offAllNamed(Approutes.login);
    }
  }
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

 if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password tidak boleh kosong');
      return;
    }
    isLoading.value = true;

    try {
      final data = await ClientNetworkLogin.post("login", {
        "username": email,
        "password": password,
      });

      print("Response: $data");

      if (data['status'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', email);

        username.value = email;
        isLoggedIn.value = true;

        Get.snackbar(
          'Sukses',
          'Login berhasil',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Approutes.home);
      } else {
        Get.snackbar(
          'Gagal',
          data['message'] ?? 'Login gagal',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    username.value = '';
    isLoggedIn.value = false;

    Get.offAllNamed(Approutes.login);
  }
}