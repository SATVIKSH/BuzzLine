import 'package:news_app/data/network/base_api_services.dart';
import 'package:news_app/data/network/network_api_services.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/res/app_urls.dart';

BaseApiServices _apiServices = NetworkAPiServices();
dynamic response;

class FetchNewsRespository {
  Future<dynamic> getAllNews() async {
    try {
      List<NewsModel> allNews = [];

      response = await _apiServices.getGetApiResponse(AppUrl.allNewsEndpoint);
      print(response['totalResults']);
      for (int i = 0; i < response['articles'].length; i++) {
        allNews.add(NewsModel(
            image: response['articles'][i]['urlToImage'],
            author: response['articles'][i]['source']['name'],
            description: response['articles'][i]['description'],
            date: response['articles'][i]['publishedAt'],
            title: response['articles'][i]['title'],
            url: response['articles'][i]['url']));
      }

      return allNews;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCategoryNews(String category, String country) async {
    try {
      List<NewsModel> allNews = [];

      response = await _apiServices
          .getGetApiResponse(AppUrl.categoryEndpoint(category, country));
      print(response['totalResults']);
      for (int i = 0; i < response['articles'].length; i++) {
        allNews.add(NewsModel(
            image: response['articles'][i]['urlToImage'],
            author: response['articles'][i]['source']['name'],
            description: response['articles'][i]['description'],
            date: response['articles'][i]['publishedAt'],
            title: response['articles'][i]['title'],
            url: response['articles'][i]['url']));
      }

      return allNews;
    } catch (e) {}
  }
}
