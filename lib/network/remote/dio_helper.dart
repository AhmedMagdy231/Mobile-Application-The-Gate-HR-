import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          receiveDataWhenStatusError: true,
          baseUrl: 'https://thegatehr.shoman.net/api/',
          //baseUrl: 'https://hr.thegate-eg.com/api/',
          //https://hr.thegate-eg.com/api/
          //https://pos.shoman.com.eg/api/
          headers: {},
      ),

    );
  }

  static Future<Response> postData({

    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String? token,
    required String url

  }) async {



    return await dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
      options: Options( headers: {"Authorization": "Bearer $token",},
      ),
    );
  }





}
