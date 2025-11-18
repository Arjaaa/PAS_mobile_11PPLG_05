import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
