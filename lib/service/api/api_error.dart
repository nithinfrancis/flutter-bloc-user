///use this class for handling application error
class APIError {
  final int errorCode;
  final String message;
  final String? key;

  static APIError noInternet = APIError(errorCode: APIErrorCodes.noInterNet, message: "Please check your internet connection and try again.");
  static APIError slowInterNet = APIError(errorCode: APIErrorCodes.slowInterNet, message: "Please check your internet connection speed and try again.");
  static APIError internalError = APIError(errorCode: APIErrorCodes.internalError, message: "Something went wrong please try again later.");
  static APIError unAuthorizedAccess = APIError(errorCode: APIErrorCodes.unAuthorizedAccess, message: "Something went wrong please re login again.");

  APIError({required this.errorCode, required this.message, this.key});

  String get getMessage => message;

  int get getErrorCode => errorCode;

  @override
  String toString() {
    return 'APIError{code: $errorCode, message: $message}';
  }

  factory APIError.fromJson(Map<String, dynamic> json, int errorCode) {
    return APIError(
      errorCode: json['code'] ?? 404,
      key: json['error'] ?? "",
      message: json['error_description'] ?? "Something went wrong Please try again.",
    );
  }
}

class APIErrorCodes {
  static const int noInterNet = 101;
  static const int slowInterNet = 101;
  static const int serverError = 102;
  static const int internalError = 103;
  static const int unAuthorizedAccess = 104;
}
