import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Api_Helper/apihelper.dart';
import 'package:news_api/AppConstant/constant.dart';
import 'package:news_api/bloc/news_bloc.dart';

void main() {
  runApp(BlocProvider<News_Bloc>(
      create: (context) => News_Bloc(api_helper: Api_Helper()),
      child: MaterialApp(
        initialRoute: AppRoutes.ROUTE_SPLASH,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      )));
}

