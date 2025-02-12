import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesScreen extends StatelessWidget {
  final String title;

  CoursesScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(fontSize: 20.sp))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            "All courses related to $title will be shown here.",
            style: TextStyle(fontSize: 18.sp, color: Colors.blue.shade800),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
