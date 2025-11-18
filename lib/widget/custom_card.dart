// ...existing code...
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';
import 'package:pas_mobile_11pplg1_05/controller/bookmark_controller.dart';
import 'package:pas_mobile_11pplg1_05/controller/store_controller.dart';

class CustomCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final String image;
  final Rating rating;

  const CustomCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  Color _categoryColor(Category cat) {
    final key = cat.toString().split('.').last.toLowerCase();
    if (key.contains('elect')) return Colors.blue;
    if (key.contains('jewel')) return Colors.purple;
    if (key.contains('men') || key.contains('women')) return Colors.teal;
    return Colors.grey;
  }

  String _categoryText(Category cat) {
    final s = cat.toString().split('.').last;
    final out = s.replaceAll('_', ' ');
    if (out.isEmpty) return '';
    return out[0].toUpperCase() + out.substring(1);
  }

  Store _toStore() {
    return Store(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    );
  }

  @override
  Widget build(BuildContext context) {
    // use existing controller if registered, otherwise put one
    final bookmarkCtrl = Get.isRegistered<BookmarkController>()
        ? Get.find<BookmarkController>()
        : Get.put(BookmarkController());
    // ensure StoreController is available for restore/remove actions (no-op if not registered)
    if (!Get.isRegistered<StoreController>()) {
      // don't create store controller here if you don't want; optional
      // Get.put(StoreController());
    }

    final img = image.isNotEmpty ? image : 'https://via.placeholder.com/100';
    final catColor = _categoryColor(category);
    final catText = _categoryText(category);
    final ratingValue = rating.rate;
    final store = _toStore();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              img,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text('\$${price.toStringAsFixed(2)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.label, color: catColor, size: 16),
                        const SizedBox(width: 6),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 80),
                          child: Text(
                            catText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: catColor, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 28),
                          child: Text(
                            ratingValue.toStringAsFixed(1),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Reactive bookmark icon
          Obx(() {
            final isBook = bookmarkCtrl.bookmarks.any((s) => s.id == id);
            return IconButton(
              icon: Icon(isBook ? Icons.bookmark : Icons.bookmark_border,
                  color: isBook ? Colors.amber : null),
              onPressed: () async {
                await bookmarkCtrl.toggleBookmark(store, navigateToBookmarks: false);
                // UI will update via bookmarkCtrl.bookmarks Rx
              },
            );
          }),
        ],
      ),
    );
  }
}