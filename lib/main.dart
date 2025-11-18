import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/routes/pages.dart';
import 'package:pas_mobile_11pplg1_05/routes/routes.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter FCM Demo',
      initialRoute: Approutes.splashscreen,
      getPages: AppPages.pages,
    );
  }
}
