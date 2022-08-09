import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:gasvigil/Screens/Home/home_screen.dart';
import 'package:gasvigil/Screens/MyDevices/my_devices_screen.dart';
import 'package:gasvigil/Screens/Profile/profile_screen.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);
  final homeScreenController =
      Get.put<HomeScreenController>(HomeScreenController());
  List<Widget> pages = const [
    HomeScreen(),
    MydevicesScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.pager,
                size: 24,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.pager,
                size: 20,
              ),
              label: '•',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.stacked_line_chart_rounded,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.stacked_line_chart_rounded,
                size: 24,
              ),
              label: '•',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.account_circle_rounded,
                size: 24,
              ),
              label: '•',
              tooltip: '',
            )
          ],
          backgroundColor: ColorConstants.darkBackground,
          currentIndex: homeScreenController.currentPage.value,
          selectedItemColor: ColorConstants.primaryColor,
          unselectedItemColor: ColorConstants.grayLight,
          onTap: (i) {
            homeScreenController.currentPage.value = i;
          },
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      body: Obx(() => pages[homeScreenController.currentPage.value]),
    );
  }
}
