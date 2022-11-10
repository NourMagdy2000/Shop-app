import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Dio_helper {
  static late Dio  dio;
//https://student.valuxapps.com/api/
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {'Content-Type': 'application/json'}
    ));
  }

  static Future<Response> getData(
      {required String path,
     Map<String, dynamic>? query,
      String ?lang = 'en',
      String ?token}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.get(path, queryParameters: query ?? null);
  }

  static Future<Response> postData(
      {required String path,
      Map<String, dynamic> ?parameters,String lang='en',String ?token,
      required  Map<String, dynamic> data}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.post(path,
   data: data
    );
  }


  static Future<Response> putData(
      {required String path,
        Map<String, dynamic> ?parameters,String lang='en',String ?token,
        required  Map<String, dynamic> data}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.put(path,
        data: data
    );
  }
}
