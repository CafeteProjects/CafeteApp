import 'package:flutter/material.dart';
import '../pages/menu_page.dart';
import '../pages/homepage_page.dart';
import '../pages/news_page.dart';


class AppRoutes {
  static const home = '/';
  static const menu = '/menu';
  static const news = '/news';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),  // Startseite
      menu: (context) => MenuPage(),
      news: (context) => Test(),
    };
  }
}