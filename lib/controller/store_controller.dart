import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';
import '../network/client_network_store.dart';

class StoreController extends GetxController {
  var products = <Store>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var isMobile = true.obs;

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result = await ClientNetworkStore.get("/products");

      products.assignAll(
        storeFromJson(result),
      );
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
