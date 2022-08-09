import 'package:gasvigil/Screens/AboutUs/about_us_screen.dart';
import 'package:gasvigil/Screens/AddDevice/add_device_screen.dart';
import 'package:gasvigil/Screens/Authentication/login_screen.dart';
import 'package:gasvigil/Screens/ContactUs/contact_us.dart';
import 'package:gasvigil/Screens/FAQ/faq_screen.dart';
import 'package:gasvigil/Screens/Home/dash_board_screen.dart';
import 'package:gasvigil/Screens/Home/home_screen.dart';
import 'package:gasvigil/Screens/Setting/notification_setting_screen.dart';
import 'package:gasvigil/Screens/SplashScreen/splash_screen.dart';
import 'package:gasvigil/Screens/WebView/webview_screen.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.logInScreen,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.dashBoardScreen,
      page: () => DashBoardScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.addDeviceScreen,
      page: () => const AddDeviceScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.aboutUsScreen,
      page: () => AboutUsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.faqScreen,
      page: () => const FaqScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.notificationSettingScreen,
      page: () => const NotificationSettingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.contactUsScreen,
      page: () => ContactUsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.webViewScreen,
      page: () => const WebViewScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
