import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/controller/bookmark_controller.dart';
import 'package:pas_mobile_11pplg1_05/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/store_page.dart';
import '../controller/home_controller.dart';
import '../controller/store_controller.dart';
import '../controller/profile_controller.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.put(HomeController());

   final StoreController api1Controller = Get.put(StoreController());
   final BookmarkController api2Controller = Get.put(BookmarkController());
  final ProfileController profileController = Get.put(ProfileController());

  final List<Widget> pages = [
    StorePage(),
     BookmarkPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[homeController.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeController.currentIndex.value,
            onTap: homeController.changeTab,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: "Store",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ));
  }
}
