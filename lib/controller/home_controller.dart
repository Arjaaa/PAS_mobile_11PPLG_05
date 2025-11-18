import 'package:get/get.dart';
import '../controller/login_controller.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final loginController = Get.find<LoginController>();
  void changeTab(int index) {
    currentIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
    print('HomeController initialized');
  }
}
