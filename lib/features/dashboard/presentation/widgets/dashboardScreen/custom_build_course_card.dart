import 'package:flutter/material.dart';

class CustomBuildCourseCard extends StatelessWidget {
  String title;
  String mentor;
  Color color;

  CustomBuildCourseCard(this.title, this.mentor, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.book, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 4),
          Text(mentor, style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
