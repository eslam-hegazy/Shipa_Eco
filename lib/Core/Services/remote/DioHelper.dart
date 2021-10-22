import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'en',
          }),
    );
  }

  static Future<Response> getData({
    required String? url,
    Map<String, dynamic>? query,
    required String token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": "en",
      "Authorization": "$token",
    };
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String? url,
    Map<String, dynamic>? query,
  }) async {
    return dio!.post(
      url!,
      queryParameters: query,
    );
  }
}
