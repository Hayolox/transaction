import 'package:dio/dio.dart';

class BaseUrl {
  final Dio dio;
  static final BaseUrl _api = BaseUrl._internal(Dio(
    BaseOptions(baseUrl: 'http://192.168.100.4:8000/api/'),
  ));

  factory BaseUrl() => _api;

  BaseUrl._internal(this.dio);
}
