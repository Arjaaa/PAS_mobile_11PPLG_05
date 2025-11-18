import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';
import 'package:pas_mobile_11pplg1_05/widget/custom_card.dart';
import 'package:pas_mobile_11pplg1_05/controller/bookmark_controller.dart';

class BookmarkPage extends GetView<BookmarkController> {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.isRegistered<BookmarkController>()
        ? Get.find<BookmarkController>()
        : Get.put(BookmarkController());

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final list = ctrl.bookmarks;
        if (list.isEmpty) return const Center(child: Text('No bookmarks'));

        return RefreshIndicator(
          onRefresh: ctrl.loadBookmarks,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final item = list[i];
              return Dismissible(
                key: ValueKey(item.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete_forever, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  await ctrl.removeBookmark(item.id);
                },
                child: CustomCard(
                  id: item.id,
                  title: item.title,
                  price: item.price,
                  description: item.description,
                  category: item.category,
                  image: item.image,
                  rating: item.rating,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}