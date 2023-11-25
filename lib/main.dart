import 'package:flutter/material.dart';
import 'package:quadb_assignment/home.dart';
import 'package:quadb_assignment/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(home: Home());
    });
  }
}
