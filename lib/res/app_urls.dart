import 'package:intl/intl.dart';

class AppUrl {
  static const _country = 'in';
  static const API_KEY = '32ca0da942614e30b7f2d0af8d9639c6';
  static const baseUrl = 'https://newsapi.org/v2';

  static const allNewsEndpoint =
      '$baseUrl/top-headlines?country=$_country&apiKey=$API_KEY';

  static final everythingEndPoint =
      '$baseUrl/top-headlines?from=${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 3)))}&apiKey=$API_KEY';

  static String categoryEndpoint(String keyword) {
    return '$baseUrl/top-headlines?country=$_country&category=$keyword&apiKey=$API_KEY';
  }
}
