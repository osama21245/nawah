import 'package:flutter/material.dart';
import 'package:nawah/features/courseScreenEnrollment/presentation/screens/course_screen_enrollment.dart';
import 'package:nawah/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nawah/features/notificationScreen/presentation/screens/notification_screen.dart';
import 'package:nawah/features/profileScreen/presentation/screens/profile.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          index = value;
          setState(() {});
        },
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  List<Widget> tabs = [
    DashboardScreen(),
    CourseScreenEnrollment(),
    NotificationScreen(),
    ProfileScreenClass()
  ];
}
