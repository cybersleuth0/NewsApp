import 'package:flutter/cupertino.dart';

import '../UI_Pages/homepage.dart';
import '../UI_Pages/splashScreen.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = "/splash";
  static const String ROUTE_BASEPAGE = "/homepage";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_SPLASH: (context) => SplashScreen(),
    ROUTE_BASEPAGE: (context) => Homepage(),
  };
}
