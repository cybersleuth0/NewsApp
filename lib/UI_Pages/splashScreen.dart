import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_api/AppConstant/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _splashState();
}

class _splashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_BASEPAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        image: AssetImage("Assets/Images/splashScreen.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }
}
