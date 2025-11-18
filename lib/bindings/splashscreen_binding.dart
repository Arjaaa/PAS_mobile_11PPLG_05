import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashscreenController>(() => SplashscreenController());
  }
}
