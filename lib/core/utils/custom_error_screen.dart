import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

customErorrScreen() {
  return ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Image.asset("assets/images/arrow_down.png"),
            Text(
              details.exception.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  };
}
