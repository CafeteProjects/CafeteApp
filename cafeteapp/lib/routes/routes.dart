import 'package:flutter/material.dart';
import '../pages/menu_page.dart';
import '../pages/homepage_page.dart';


class AppRoutes {
  static const home = '/';
  static const menu = '/menu';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),  // Startseite
      menu: (context) => MenuPage(),
    };
  }
}