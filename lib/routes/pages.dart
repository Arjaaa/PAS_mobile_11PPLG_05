import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_05/bindings/home_binding.dart';
import 'package:pas_mobile_11pplg1_05/bindings/login_binding.dart';
import 'package:pas_mobile_11pplg1_05/bindings/profile_binding.dart';
import 'package:pas_mobile_11pplg1_05/bindings/register_binding.dart';
import 'package:pas_mobile_11pplg1_05/bindings/splashscreen_binding.dart';
import 'package:pas_mobile_11pplg1_05/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/home_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/login_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/profile_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/register_page.dart';
import 'package:pas_mobile_11pplg1_05/pages/splashscreen_page.dart';
import 'package:pas_mobile_11pplg1_05/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Approutes.login, 
    page: () => LoginPage(), 
    binding: LoginBinding() 
    ),
    GetPage(name: Approutes.profile, 
    page: () => ProfilePage(), 
    binding: ProfileBinding() 
    ),
    GetPage(name: Approutes.splashscreen, 
    page: () => SplashScreenPage(), 
    binding: SplashscreenBinding() 
    ),
    GetPage(name: Approutes.home, 
    page: () => HomePage(), 
    binding: HomeBinding() 
    ),
    GetPage(name: Approutes.register, 
    page: () => RegisterPage(), 
    binding: RegisterBinding() 
    ),
    GetPage(name: Approutes.boookmark, 
    page: () => BookmarkPage()
    ),
  ];
}