import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  ProfileOption({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.r,
                spreadRadius: 1.r)
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 24.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 16.sp)),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
