import 'package:news_app/data/response/status.dart';

class ApiResponses<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponses({this.data, this.status, this.message});
  ApiResponses.loading() : status = Status.LOADING;
  ApiResponses.completed({required this.data}) : status = Status.COMPLETED;
  ApiResponses.error({required this.message}) : status = Status.ERROR;
}
