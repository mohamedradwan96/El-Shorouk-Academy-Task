import 'package:dio/dio.dart';

import 'api.dart';

class ApiManger {
  late Dio dio;

  ApiManger() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true, // errors showing
      connectTimeout: const Duration(seconds: 30), //60sec
      receiveTimeout: const Duration(seconds: 30), //60sec
    );

    dio = Dio(options);
  }
}
