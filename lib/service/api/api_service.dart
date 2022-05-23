import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shopping_cart/helpers/logger.dart';
import 'package:flutter_shopping_cart/helpers/shared_preference.dart';


import 'api_error.dart';

class Environment {
  static const String production = "https://jsonplaceholder.typicode.com/";
  static const String staging = "https://jsonplaceholder.typicode.com/";
  static const String local = "https://jsonplaceholder.typicode.com/";
}

bool isProduction = true;
// bool isProduction = false;

class APIService {
  static Dio dio = Dio(BaseOptions(
    baseUrl:isProduction?Environment.production:Environment.staging,
    connectTimeout: 20000,
    receiveTimeout: 20000,
    receiveDataWhenStatusError: true,
  ),
  );



  APIService()  {
    // ignore: unnecessary_null_comparison
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: isProduction?Environment.production:Environment.staging,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        receiveDataWhenStatusError: true,
      );
      dio = Dio(options);
    }
  }

  // static late String cacheDirectory;
  // static late DioCacheManager dioCacheManager;



  Future<String> _userToken() async {
    // AppSharedPreference preference = AppSharedPreference();
    // var token = await preference.getString(preferenceKeyAccessToken);
    // if (token.isNotEmpty) {
    //   token = "Bearer $token";
    // } else {
    //   throw APIError.unAuthorizedAccess;
    // }
    return "";
  }

  Future<ParsedResponse> get(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? params, bool needAuthentication = false, String? contentType}) async {
    if (needAuthentication == true && headers!["Authorization"] == null) {
      headers['Authorization'] = await _userToken();
    }
    StringBuffer buffer=StringBuffer();
    if(params!=null){
      params.forEach((key, value) {
        buffer.write(key);
        buffer.write(value.toString());
      });
    }
    final String getAPIKey = path+buffer.toString();
    AppSharedPreference pref= AppSharedPreference();
    String res = await pref.getString(getAPIKey);
    if(res.isEmpty){
      return dio.get(path, queryParameters: params, options:
      Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json"),
        // buildCacheOptions(Duration(hours: 24),
        //   forceRefresh: false, //to force refresh
        //   maxStale: Duration(days: 10),
        //   options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json"),
        // ),


      ).then((Response response) {
        final String? res = response.data;
        final int? code = response.statusCode;
        Logger.log("Status code for " + path + "::: " + code.toString());

        if (res == null || res.isEmpty) {
          throw APIError.internalError;
        } else {
          pref.setString(getAPIKey,res);
          return ParsedResponse(code!, res);
        }
      }).catchError((Object e) {
        Logger.log("Error ::: " + path + "::: " + e.toString());
        if (e is DioError) {
          handleDioException(e);
        } else {
          throw e;
        }
      });
    }
    ParsedResponse parsedResponse =ParsedResponse(
    200, res);

    print("############### From Preference");
    print(res);
    return parsedResponse;
    Logger.log("URL : $path \nHeaders : $headers queryParameters : $params");


  }

  Future<ParsedResponse> post(String path, {Map<String, dynamic>? headers, body, Map<String, dynamic>? params, encoding, bool needAuthentication = false, String? contentType}) async {
    if (needAuthentication == true && headers!['Authorization'] == null) {
      headers['Authorization'] = await _userToken();
    }

    return dio.post(path, data: body, queryParameters: params, options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json")).then((Response response) {
      final String? res = response.data;
      final int? code = response.statusCode;
      Logger.log("response status code ${response.statusCode}");
      Logger.log("Status code for " + path + "::: " + code.toString());

      if (res == null || res.isEmpty) {
        throw APIError.internalError;
      } else {
        return ParsedResponse(code!, res);
      }
    }).catchError((Object e) {
      Logger.log("Error ::: " + path + "::: " + e.toString());
      if (e is DioError) {
        handleDioException(e);
      } else {
        throw e;
      }
    });
  }

  Future<ParsedResponse> put(String path, {Map<String, dynamic>? headers, body, Map<String, dynamic>? params, encoding, bool needAuthentication = false, String? contentType}) async {
    if (needAuthentication == true && headers!['Authorization'] == null) {
      headers['Authorization'] = await _userToken();
    }


    return dio.put(path, data: body, queryParameters: params, options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json")).then((Response response) {
      final String? res = response.data;
      final int? code = response.statusCode;
      Logger.log("response status code ${response.statusCode}");
      Logger.log("Status code for " + path + "::: " + code.toString());

      if (res == null || res.isEmpty) {
        throw APIError.internalError;
      } else {
        return ParsedResponse(code!, res);
      }
    }).catchError((Object e) {
      Logger.log("Error ::: " + path + "::: " + e.toString());
      if (e is DioError) {
        handleDioException(e);
      } else {
        throw e;
      }
    });
  }
}

class ParsedResponse {
  int code;
  String response;

  ParsedResponse(this.code, this.response);

  bool isOk() {
    return code == 200;
  }

  @override
  String toString() {
    return 'ParsedResponse{code : $code, response : " $response "}';
  }
}

///All error handling should be done in this method
void handleDioException(exception) {
  if (exception is DioError) {
    ///Error is a [APIError] can be throw
    if (exception.type == DioErrorType.response) {
      if (null != exception.response) {
        dynamic json = jsonDecode(exception.response!.data);
        if (null != json) {
          throw APIError(errorCode: json["status"] ?? 0, message: json["message"] ?? json["error_description"] ?? "Something went wrong");
        }
      }
    } else if (exception.type == DioErrorType.other) {
      if (exception.error is SocketException) {
        throw APIError.noInternet;
      }
    } else if (exception.type == DioErrorType.connectTimeout || exception.type == DioErrorType.receiveTimeout) {
      throw APIError.noInternet;
    }
    throw exception;
  } else {
    throw exception;
  }
}
