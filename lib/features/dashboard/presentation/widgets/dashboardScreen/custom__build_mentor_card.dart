import 'package:flutter/material.dart';
import 'package:nawah/features/profileScreen/presentation/screens/profile.dart';

class CustomBuildMentorCard extends StatelessWidget {
  String name;
  String subject;
  int courses;

  CustomBuildMentorCard(this.name, this.subject, this.courses, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreenClass()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(height: 12),
            Text(name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(subject, style: TextStyle(color: Colors.blue)),
            Text("$courses Courses", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
