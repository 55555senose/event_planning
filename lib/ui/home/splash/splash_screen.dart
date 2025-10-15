import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:event_planning/utils/app_assets.dart';
import 'package:event_planning/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Timer(const Duration(seconds: 3), () {
  //   //   Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
  //   // });
  //   Timer(const Duration(seconds: 3), () {
  //     Navigator.pushReplacementNamed(context, AppRoutes.introRouteName);
  //   });
  // }
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.introRouteName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFFFFF), // لون خلفية مشابه للصورة
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 136,
          height: 186,
        ),
      ),
    );
  }
}
