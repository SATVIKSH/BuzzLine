import 'package:news_app/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'News',
        initialRoute: RoutesName.load,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
