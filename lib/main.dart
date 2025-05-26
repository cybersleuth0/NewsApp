import 'package:flutter/material.dart';
import 'package:news_api/AppConstant/constant.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppRoutes.ROUTE_SPLASH,
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
