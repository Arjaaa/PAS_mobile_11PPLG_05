import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/widget/custom_card.dart';
import '../../controller/store_controller.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return RefreshIndicator(
         onRefresh: controller.fetchProducts,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final char = controller.products[index];
              return CustomCard(
                id: char.id,
                title: char.title,
                price: char.price,
                description: char.description,
                category: char.category,
                image: char.image,
                rating: char.rating,
              );
            },
          ),
        );
      }),
    );
  }
}