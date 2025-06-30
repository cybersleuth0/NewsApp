import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_api/AppConstant/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _splashState();
}

class _splashState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_BASEPAGE);
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: Icon(
                  Icons.newspaper,
                  size: 100.0,
                  color: Colors.white70
                ),
              ),
            ),
            SizedBox(height: 24.0),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'News App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}