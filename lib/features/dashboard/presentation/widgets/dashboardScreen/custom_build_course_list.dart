import 'package:flutter/material.dart';

import 'custom_build_course_card.dart';

class CustomBuildCourseList extends StatelessWidget {
  const CustomBuildCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomBuildCourseCard(
                "Accounting", "Ahmed Mohamed", Colors.orange)),
        SizedBox(width: 12),
        Expanded(
            child: CustomBuildCourseCard(
                "Marketing", "Randa Mohamed", Colors.blue)),
      ],
    );
  }
}
