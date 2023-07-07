import 'dart:convert';
import 'dart:io';

import 'package:news_app/data/network/base_api_services.dart';
import 'package:news_app/data/response/app_exception.dart';
import 'package:http/http.dart' as http;

class NetworkAPiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      default:
        throw FetchDataException(
            'Error occured during communicating with servers \n Error Code:${response.statusCode}');
    }
  }
}
