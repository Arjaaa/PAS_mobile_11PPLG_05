import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/custom_button.dart';
import '../routes/routes.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const FlutterLogo(size: 100),
              const SizedBox(height: 30),
              

              const Text(
                "Login to Your Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
            CustomTextField(
            controller: controller.emailController,
            label: 'Username',
            hint: 'Masukkan username',
            icon: Icons.person_outline,
            ),

              const SizedBox(height: 20),
              CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                hint: 'Masukkan password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 30),
              Obx(() => CustomButton(
                    text: 'Login',
                    onPressed: controller.login,
                    isLoading: controller.isLoading.value,
                  )),
              const SizedBox(height: 5),
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Obx(() => CustomButton(
                    text: 'Register',
                    onPressed: ()=> Get.offAllNamed(Approutes.register),
                    isLoading: controller.isLoading.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}