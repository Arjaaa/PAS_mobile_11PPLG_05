import 'package:get/get.dart';
import '../controller/login_controller.dart';

class SplashscreenController extends GetxController {
  late final LoginController loginController;

  @override
  void onInit() {
    super.onInit();

    loginController = Get.put(LoginController());
    Future.delayed(const Duration(seconds: 2), () {
      loginController.checkLoginStatus();
    });
  }
}
