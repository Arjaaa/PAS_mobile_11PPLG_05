import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<StoreController>(() => StoreController());
  }
}
