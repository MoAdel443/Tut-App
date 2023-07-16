
// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../App/app_prefs.dart';
import '../../App/constant.dart';

const String CONTENT_TYPE = "content-type";
const String APPLICATION_JSON = "application/json";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";


class DioFactory {
  final AppPreference _appPreference;

  DioFactory(this._appPreference);

  Future<Dio> getDio() async{
    Dio dio = Dio();

    String language = await _appPreference.getAppLang();



    Map<String,String> headers = {
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:Constants.token,
      DEFAULT_LANGUAGE:language,
    };

    dio.options= BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(minutes: 1)
    );

    if(!kReleaseMode)
      {
        dio.interceptors.add(PrettyDioLogger(
          requestHeader : true,
          requestBody : true,
          responseHeader : true,
        ));
      }
    return dio;
  }
  
  

}