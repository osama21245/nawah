   import 'package:flutter/material.dart';

void NavigateFN(BuildContext context, Widget Function() myScreen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => myScreen(),
    ),
  );
}