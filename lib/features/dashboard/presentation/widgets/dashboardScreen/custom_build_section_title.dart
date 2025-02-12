import 'package:flutter/material.dart';
import 'package:nawah/features/dashboard/presentation/screens/course_screen.dart';

class CustomBuildSectionTitle extends StatelessWidget {
  BuildContext context;
  String title;
  String? action;

  CustomBuildSectionTitle(this.context, this.title, {this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (action != null)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursesScreen(title: title)),
              );
            },
            child: Text(action ?? "",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}
