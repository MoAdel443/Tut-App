
import 'package:TutApp/Presentation/main/pages/home/home_view/home_page.dart';
import 'package:TutApp/Presentation/main/pages/notification/notification_page.dart';
import 'package:TutApp/Presentation/main/pages/search/search_page.dart';
import 'package:TutApp/Presentation/main/pages/settings/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/Color_Manager.dart';
import '../resources/Strings_Manager.dart';
import '../resources/Values_Manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: ColorManager.primary),
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.ligthGrey, spreadRadius: AppSize.s1)
        ]),

        child: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          items:  [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings.tr()),
          ],
          onTap: onTap,
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
