// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_null_in_if_null_operators
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization' : token??'',
    };
    return await dio.get(url, queryParameters: query??null);
  }

  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>? query,
    String lang ='en',
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization' : token??'',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    String lang ='en',
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization' : token??'',
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
