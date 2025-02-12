import 'package:flutter/material.dart';
import 'package:nawah/features/dashboard/presentation/widgets/dashboardScreen/custom__build_mentor_card.dart';

class CustomBuildMentorGrid extends StatelessWidget {
  const CustomBuildMentorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        CustomBuildMentorCard("Ahmed Mohamed", "Biology Teacher", 23),
        CustomBuildMentorCard("Randa Mohamed", "History Teacher", 20),
        CustomBuildMentorCard("Ahmed Mohamed", "Physics Teacher", 18),
        CustomBuildMentorCard("Randa Mohamed", "Chemistry Teacher", 25),
      ],
    );
  }
}
