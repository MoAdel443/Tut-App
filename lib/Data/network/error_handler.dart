// ignore_for_file: constant_identifier_names

import 'package:TutApp/Data/network/failure.dart';
import 'package:TutApp/Presentation/resources/Strings_Manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';



class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSourse.DEFAULT.getFailure();
    }
  }
}
  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSourse.CONNENT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSourse.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSourse.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSourse.BAD_REQUEST.getFailure();
      case DioExceptionType.badResponse:
        if (error.response != null &&
            error.response?.statusMessage != null &&
            error.response?.statusCode != null) {
          return Failure(error.response?.statusCode ?? 0,
              error.response?.statusMessage ?? "");
        } else {
          return DataSourse.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSourse.CANCLE.getFailure();
      case DioExceptionType.connectionError:
        return DataSourse.CONNENT_TIMEOUT.getFailure();
      case DioExceptionType.unknown:
        return DataSourse.DEFAULT.getFailure();
    }
  }


enum DataSourse {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNENT_TIMEOUT,
  CANCLE,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CHACHE_ERROE,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourseExtention on DataSourse {
  Failure getFailure() {
    switch (this) {
      case DataSourse.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMassage.SUCCESS.tr());
      case DataSourse.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMassage.NO_CONTENT.tr());
      case DataSourse.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMassage.BAD_REQUEST.tr());
      case DataSourse.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMassage.FORBIDDEN.tr());
      case DataSourse.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMassage.UNAUTHORIZED.tr());
      case DataSourse.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMassage.NOT_FOUND.tr());
      case DataSourse.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMassage.INTERNAL_SERVER_ERROR.tr());
      case DataSourse.CONNENT_TIMEOUT:
        return Failure(
            ResponseCode.CONNENT_TIMEOUT, ResponseMassage.CONNENT_TIMEOUT.tr());
      case DataSourse.CANCLE:
        return Failure(ResponseCode.CANCLE, ResponseMassage.CANCLE.tr());
      case DataSourse.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMassage.RECEIVE_TIMEOUT.tr());
      case DataSourse.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMassage.SEND_TIMEOUT.tr());
      case DataSourse.CHACHE_ERROE:
        return Failure(ResponseCode.CHACHE_ERROE, ResponseMassage.CHACHE_ERROE.tr());
      case DataSourse.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMassage.NO_INTERNET_CONNECTION.tr());
      case DataSourse.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMassage.DEFAULT.tr());
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success without data
  static const int BAD_REQUEST = 400; // failure , api rejected
  static const int UNAUTHORIZED = 401; // user is not auth
  static const int FORBIDDEN = 403; //failure , api rejected
  static const int NOT_FOUND = 404; // not found
  static const int INTERNAL_SERVER_ERROR = 500; // server error

  //local status code
  static const int CONNENT_TIMEOUT = -1;
  static const int CANCLE = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CHACHE_ERROE = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMassage {
  static const String SUCCESS = AppStrings.success;
  static const String NO_CONTENT = AppStrings.success;
  static const String BAD_REQUEST = AppStrings.badRequestError;
  static const String UNAUTHORIZED = AppStrings.unauthorizedError;
  static const String FORBIDDEN = AppStrings.forbiddenError;
  static const String NOT_FOUND = AppStrings.unauthorizedError;
  static const String INTERNAL_SERVER_ERROR = AppStrings.noInternetError;

  //local status code
  static const String CONNENT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCLE = "user cancle the operation";
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CHACHE_ERROE = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static const String DEFAULT = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
