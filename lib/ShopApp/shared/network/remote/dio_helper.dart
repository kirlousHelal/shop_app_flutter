import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response?> getData({
    required String url,
    bool isEnglish = true,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio?.options.headers = {
      "Content-Type": "application/json",
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
    };
    return await dio?.get(
      url,
      queryParameters: queryParameters,
    );
  }

  static Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
    bool isEnglish = true,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio?.options.headers = {
      "Content-Type": "application/json",
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
    };
    return await dio?.post(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response?> putData({
    required String url,
    required Map<String, dynamic> data,
    bool isEnglish = true,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio?.options.headers = {
      "Content-Type": "application/json",
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
    };
    return await dio?.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
