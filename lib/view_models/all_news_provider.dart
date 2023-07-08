import 'package:intl/intl.dart';
import 'package:news_app/data/response/api_response.dart';

import 'package:news_app/models/news_model.dart';

import 'package:news_app/repository/fetch_news_repository.dart';
import 'package:news_app/utils/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AllNewsNotifier extends StateNotifier<ApiResponses<List<NewsModel>>> {
  AllNewsNotifier() : super(ApiResponses());
  final _fetchRepo = FetchNewsRespository();

  void getAllNews(BuildContext context) {
    ApiResponses.loading();
    _fetchRepo.getAllNews().then((value) {
      state = ApiResponses.completed(data: value);
      Navigator.of(context).pushReplacementNamed(RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      state = ApiResponses.error(message: error.toString());
      if (kDebugMode) {
        print(DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 3))));
        print(error.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occured')));
      }
    });
  }

  void getCategoryNews(
      {required String category,
      required BuildContext context,
      required String country}) {
    state = ApiResponses.loading();
    _fetchRepo.getCategoryNews(category, country).then((value) {
      state = ApiResponses.completed(data: value);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      state = ApiResponses.error(message: error.toString());
      if (kDebugMode) {
        print(error.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occured')));
      }
    });
  }
}

final allNewsProvider =
    StateNotifierProvider<AllNewsNotifier, ApiResponses<List<NewsModel>>>(
        (ref) => AllNewsNotifier());
