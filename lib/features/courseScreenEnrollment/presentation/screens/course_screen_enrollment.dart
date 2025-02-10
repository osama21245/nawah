import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawah/features/profileScreen/presentation/screens/profile.dart';

class CourseScreenEnrollment extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      'tutor': 'Tina Hill',
      'course': 'Figma Basic',
      'hours': '8 Hours',
      'rating': '4.9 Rating',
      'color': Colors.lightBlueAccent,
      'image': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'tutor': 'Siam Joy',
      'course': 'Graphic Design',
      'hours': '6 Hours',
      'rating': '4.8 Rating',
      'color': Colors.yellowAccent,
      'image': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'tutor': 'Hena Will',
      'course': 'UI/UX Design',
      'hours': '5 Hours',
      'rating': '4.7 Rating',
      'color': Colors.greenAccent,
      'image': 'https://i.pravatar.cc/150?img=3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.white,
        title: Text(
          'Courses You\nEnrolled',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemExtent: 250.h,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(
              tutor: course['tutor'],
              course: course['course'],
              hours: course['hours'],
              rating: course['rating'],
              color: course['color'],
              image: course['image'],
            );
          },
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String tutor;
  final String course;
  final String hours;
  final String rating;
  final Color color;
  final String image;

  CourseCard(
      {required this.tutor,
      required this.course,
      required this.hours,
      required this.rating,
      required this.color,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileScreenClass()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(width: 15.w),
                Text(
                  tutor,
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.double_arrow),
                  color: Colors.white,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              'Course',
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
            SizedBox(height: 5.h),
            Text(
              course,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hours, style: TextStyle(fontSize: 14.sp)),
                Text(rating, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
