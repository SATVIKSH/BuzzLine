import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/routes_name.dart';
import 'package:news_app/views/screens/home_screen.dart';
import 'package:news_app/views/screens/news_detail_screen.dart';
import 'package:news_app/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.load:
        return MaterialPageRoute(builder: ((context) => const LoadScreen()));
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.newsDetail:
        return MaterialPageRoute(
            builder: (context) =>
                NewsDetailScreen(news: settings.arguments as NewsModel));
      default:
        return MaterialPageRoute(builder: ((_) {
          return const Scaffold(body: Center(child: Text("No Route Defined")));
        }));
    }
  }
}
