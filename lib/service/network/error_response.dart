import 'package:dio/dio.dart';

class ErrorResponse {
  String message;
  int? code;
  dynamic data;
  int? status;

  ErrorResponse({required this.message, this.code, this.data, this.status});

  // Parse error response
  factory ErrorResponse.fromDioError(DioError error) {
    try {
      return ErrorResponse(
          message: error.response?.data['message'] ?? "Error!",
          data: error.response?.data,
          code: error.response?.statusCode);
    } catch (e) {
      return ErrorResponse(
          message: 'Error occurred',
          data: null,
          code: error.response?.statusCode);
    }
  }
}
