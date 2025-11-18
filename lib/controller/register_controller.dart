import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_05/network/client_network_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/register_models.dart';
import '../routes/routes.dart';

class RegisterController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final emails = TextEditingController();

  var isLoading = false.obs;
  var registerStatus = "".obs;

  Future<void> register() async {
 final user = username.text.trim();
    final pass = password.text.trim();
    final full = fullname.text.trim();
    final email = emails.text.trim();

    if (user.isEmpty || pass.isEmpty || full.isEmpty || email.isEmpty) {
      Get.snackbar("Error", "Tidak Boleh ada yang kosong");
      return;
    }

    isLoading.value = true;
    registerStatus.value = "";

    try {
      final resp = await ClientNetworkRegister.postForm('register-user', {
        'username': user,
        'password': pass,
        'full_name': full,
        'email': email,
      });

      debugPrint('register response: $resp');

      final registerModel = RegisterModel.fromJson(resp);
     if (registerModel.status == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user);
        await prefs.setString('full_name', full);
        await prefs.setString('email', email);

        Get.snackbar(
          "Sukses",
          registerModel.message,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        Get.offAllNamed(Approutes.login);
      } else {
        registerStatus.value = "register gagal: ${registerModel.message}";
        Get.snackbar("Gagal", registerModel.message);
      }
    } catch (e) {
      // tampilkan detail agar mudah debug 404/endpoint
     registerStatus.value = "Terjadi kesalahan: $e";
     Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
        isLoading.value = false;
    }
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    fullname.dispose();
    emails.dispose();
    super.onClose();
  }
}