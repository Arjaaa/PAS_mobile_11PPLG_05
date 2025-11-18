import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
