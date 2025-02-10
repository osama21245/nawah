import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home_screen/profile_screen/custom_circle_avatar.dart';
import '../widgets/home_screen/profile_screen/custom_profile_option.dart';
import '../widgets/home_screen/profile_screen/dark_mode_switch.dart';

class ProfileScreenClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black, size: 24.sp),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomCircleAvatar(),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileOption(icon: Icons.person, title: 'Personal Details'),
                  ProfileOption(icon: Icons.favorite, title: 'Wishlist'),
                  ProfileOption(icon: Icons.download, title: 'Your Download'),
                  DarkModeSwitch(),
                  SizedBox(height: 20.h),
                  ProfileOption(icon: Icons.history, title: 'Order History'),
                  ProfileOption(
                      icon: Icons.card_giftcard, title: 'Referral Code'),
                  ProfileOption(
                      icon: Icons.confirmation_num, title: 'Voucher Code'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
