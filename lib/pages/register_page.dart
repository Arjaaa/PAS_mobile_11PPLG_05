import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/register_controller.dart';
import 'package:pas_mobile_11pplg1_05/pages/login_page.dart';
import 'package:pas_mobile_11pplg1_05/widget/custom_textfield.dart';
import 'package:pas_mobile_11pplg1_05/widget/custom_button.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<RegisterController>()) {
      Get.put(RegisterController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 35),
              const FlutterLogo(size: 100),
              const SizedBox(height: 30),
              const Text(
                "Create an account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                controller: controller.username,
                label: 'Username',
                hint: 'Masukkan username',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: controller.password,
                label: 'Password',
                hint: 'Masukkan password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: controller.fullname,
                label: 'Full Name',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: controller.emails,
                label: 'Email',
                hint: 'Masukkan email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),

              Obx(() => CustomButton(
                    text: 'Register',
                    onPressed: () async {
                      await controller.register();
                      if (controller.registerStatus.value
                          .toLowerCase()
                          .contains("success")) {
                        Get.snackbar(
                          "Sukses",
                          "Akun berhasil dibuat",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Get.offAll(() => LoginPage());
                      }
                    },
                    isLoading: controller.isLoading.value,
                  )),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}