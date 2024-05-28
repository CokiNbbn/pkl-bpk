import 'package:flutter/material.dart';
import 'package:test_pkl/screens/log/log_screen.dart';
import 'package:test_pkl/screens/home/home_screen.dart';
import 'package:test_pkl/screens/notification_screen.dart';
import 'package:test_pkl/screens/account/account_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    this.pageIndex = 0,
  });

  final int pageIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentPageIndex;

  @override
  void initState() {
    _currentPageIndex = widget.pageIndex;
    super.initState();
  }

  final List<Widget> pages = const [
    HomeScreen(),
    LogScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: pages[_currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        indicatorColor: Colors.amberAccent,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int selectedIndex) {
          setState(() {
            _currentPageIndex = selectedIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: Icon(Icons.task),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person_2),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
