import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_shopping_cart/helpers/logger.dart';
import 'package:flutter_shopping_cart/src/album/models/rm_album.dart';
import 'package:flutter_shopping_cart/src/comments/models/rm_comment.dart';
import 'package:flutter_shopping_cart/src/photos/models/rm_photos.dart';
import 'package:flutter_shopping_cart/src/post/models/rm_post.dart';
import 'package:flutter_shopping_cart/src/user/models/rm_user.dart';

import 'api_error.dart';
import 'api_service.dart';

class APIManager {
  APIManager();

  static APIService apiService = APIService();

  static const String users = "users";
  static const String posts = "posts";
  static const String comments = "comments";
  static const String albums = "albums";
  static const String photos = "photos";

  Future<dynamic> getAllUsers() async {
    try {
      var params = <String, dynamic>{};
      var headers = <String, String>{};

      ParsedResponse result = await apiService.get(
        users,
        params: params,
        headers: headers,
        needAuthentication: true,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        var response = jsonDecode(result.response);

        if (null != response && response.isNotEmpty) {
          List<RMUser> userList =
              List<RMUser>.from(response.map((x) => RMUser.fromJson(x)));

          return userList;

          // RMPaymentList paymentList = RMPaymentList.fromJson(response);
          return [];
        } else {
          throw APIError(
              errorCode: result.code,
              message: response["msg"] ?? "Internal server error");
        }
      } else if (result.response.isNotEmpty) {
        final eventPlusError =
            APIError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw APIError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw APIError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }

  Future<dynamic> getPostsById(String userId) async {
    try {
      var params = <String, dynamic>{};
      var headers = <String, String>{};

      params["userId"] = userId;

      ParsedResponse result = await apiService.get(
        posts,
        params: params,
        headers: headers,
        needAuthentication: true,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        var response = jsonDecode(result.response);

        if (null != response && response.isNotEmpty) {
          List<RMPost> userList =
              List<RMPost>.from(response.map((x) => RMPost.fromJson(x)));

          return userList;

          // RMPaymentList paymentList = RMPaymentList.fromJson(response);
          return [];
        } else {
          throw APIError(
              errorCode: result.code,
              message: response["msg"] ?? "Internal server error");
        }
      } else if (result.response.isNotEmpty) {
        final eventPlusError =
            APIError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw APIError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw APIError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }

  Future<dynamic> getAlbumsById(String userId) async {
    try {
      var params = <String, dynamic>{};
      var headers = <String, String>{};

      params["userId"] = userId;

      ParsedResponse result = await apiService.get(
        albums,
        params: params,
        headers: headers,
        needAuthentication: true,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        var response = jsonDecode(result.response);

        if (null != response && response.isNotEmpty) {
          List<RMAlbum> userList =
              List<RMAlbum>.from(response.map((x) => RMAlbum.fromJson(x)));

          return userList;

          // RMPaymentList paymentList = RMPaymentList.fromJson(response);
          return [];
        } else {
          throw APIError(
              errorCode: result.code,
              message: response["msg"] ?? "Internal server error");
        }
      } else if (result.response.isNotEmpty) {
        final eventPlusError =
            APIError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw APIError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw APIError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }

  Future<dynamic> getPhotosById(String albumId) async {
    try {
      var params = <String, dynamic>{};
      var headers = <String, String>{};

      params["albumId"] = albumId;

      ParsedResponse result = await apiService.get(
        photos,
        params: params,
        headers: headers,
        needAuthentication: true,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        var response = jsonDecode(result.response);

        if (null != response && response.isNotEmpty) {
          List<RMPhotos> userList =
              List<RMPhotos>.from(response.map((x) => RMPhotos.fromJson(x)));

          return userList;

        } else {
          throw APIError(
              errorCode: result.code,
              message: response["msg"] ?? "Internal server error");
        }
      } else if (result.response.isNotEmpty) {
        final eventPlusError =
            APIError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw APIError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw APIError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }

  Future<dynamic> getCommentsById(String postId) async {
    try {
      var params = <String, dynamic>{};
      var headers = <String, String>{};

      params["postId"] = postId;

      ParsedResponse result = await apiService.get(
        comments,
        params: params,
        headers: headers,
        needAuthentication: true,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        var response = jsonDecode(result.response);

        if (null != response && response.isNotEmpty) {
          List<RMComment> userList =
              List<RMComment>.from(response.map((x) => RMComment.fromJson(x)));

          return userList;

          // RMPaymentList paymentList = RMPaymentList.fromJson(response);
          return [];
        } else {
          throw APIError(
              errorCode: result.code,
              message: response["msg"] ?? "Internal server error");
        }
      } else if (result.response.isNotEmpty) {
        final eventPlusError =
            APIError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw APIError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw APIError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }
}

extension LocalizedMessage on Exception {
  String getMessage() {
    String message = toString();
    if (message.isEmpty) {
      message = "Something went wrong";
    } else if (message.contains("Exception: ")) {
      message = message.replaceFirst("Exception: ", "");
    }
    return message;
  }
}

///All error handling should be done in this method
void throwProperException(exception) {
  if (exception is APIError) {
    ///Error is a [APIError] can be throw
    throw exception;
  } else if (exception is SocketException) {
    throw APIError.noInternet;
  } else if (exception is TimeoutException) {
    throw APIError.slowInterNet;
  } else if (exception is FormatException) {
    throw APIError.internalError;
  } else {
    throw APIError.internalError;
  }
}
