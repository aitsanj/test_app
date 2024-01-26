import 'package:ap_for_interview/dictionary/colors.dart';
import 'package:ap_for_interview/notifier/profile_info.notifier.dart';
import 'package:ap_for_interview/notifier/tab.notifier.dart';
import 'package:ap_for_interview/screens/home_screen.dart';
import 'package:ap_for_interview/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          flexibleSpace: tabProvider.selectedTab != 0
              ? SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(top: 14),
                    child: InkWell(
                      onTap: () {
                        if (tabProvider.selectedTab == 1) {
                          if (profileProvider.selectedOption != '') {
                            profileProvider.buttonController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                            profileProvider.selectedOption = '';
                          } else {
                            tabProvider.selectedTab = 0;
                          }
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.chevron_left,
                            color: primaryBlue,
                            size: 30,
                          ),
                          Text(
                            profileProvider.selectedOption != ''
                                ? 'Аккаунт'
                                : 'Мой аккаунт',
                            style: const TextStyle(
                                color: primaryBlue, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          shape:
              const Border(bottom: BorderSide(color: borderGrey, width: 0.5)),
          title: tabProvider.selectedTab != 0
              ? const Text(
                  'Аккаунт',
                  style: TextStyle(
                      color: primaryGrey,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )
              : null,
        ),
        bottomNavigationBar: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: divider, width: 1))),
          child: BottomNavigationBar(
            backgroundColor:
                tabProvider.selectedTab == 0 ? background : borderGrey,
            selectedItemColor: primaryBlue,
            unselectedItemColor: unselectedNavBarItem,
            selectedLabelStyle:
                const TextStyle(color: primaryBlue, fontSize: 11),
            unselectedLabelStyle:
                const TextStyle(color: primaryGrey, fontSize: 11),
            selectedFontSize: 10,
            showUnselectedLabels: true,
            currentIndex: tabProvider.selectedTab,
            onTap: (value) {
              tabProvider.selectedTab = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, top: 7),
                  child: Image.asset(
                    'lib/assets/navbar/main_unselected.png',
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Image.asset(
                    'lib/assets/navbar/main.png',
                  ),
                ),
                label: 'Мои проекты',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, top: 7),
                  child: Image.asset(
                    'lib/assets/navbar/profile.png',
                    color: primaryGrey,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Image.asset(
                    'lib/assets/navbar/profile.png',
                    color: primaryBlue,
                  ),
                ),
                label: 'Мой аккаунт',
              ),
            ],
          ),
        ),
        body: _widgetOptions[tabProvider.selectedTab]);
  }
}
