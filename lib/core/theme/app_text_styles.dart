import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTextStyles {
  // Item Card Text Styles
  static const TextStyle itemTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemQuantity = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle itemUnitPrice = TextStyle(
    fontSize: 14,
    color: AppPallete.blueColor,
  );

  static const TextStyle itemTotalPrice = TextStyle(
    fontSize: 14,
    color: AppPallete.blueColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemUnitWholesale = TextStyle(
    fontSize: 14,
    color: AppPallete.orangeColor,
  );

  static const TextStyle itemTotalWholesale = TextStyle(
    fontSize: 14,
    color: AppPallete.orangeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemProfit = TextStyle(
    fontSize: 14,
    color: AppPallete.greenColor,
    fontWeight: FontWeight.bold,
  );

  // Summary Card Text Styles
  static const TextStyle summaryText = TextStyle(
    fontSize: 16,
  );

  static const TextStyle summaryProfit = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppPallete.greenColor,
  );
}
