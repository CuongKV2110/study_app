import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'error_response.dart';

class DioClient {
  late Dio _dio;
  final _timeout = 10000;

  final baseUrl = 'https://hiring-test.stag.tekoapis.net/api/';
  DioClient() {
    final baseOption = BaseOptions(
      //add BASE_URL in env to baseUrl
      baseUrl: baseUrl,

      connectTimeout: Duration(seconds: _timeout),
      receiveDataWhenStatusError: true,
      contentType: "application/json",
    );

    _dio = Dio(baseOption);
    final tokenDio = Dio(baseOption);
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return excuteRequest(() => _dio.get(url,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters));
  }

  Future<Response<T>> post<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return excuteRequest(() => _dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress));
  }

  Future<Response<T>> put<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return excuteRequest(() => _dio.put(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress));
  }

  Future<Response<T>> patch<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return excuteRequest(() => _dio.patch(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress));
  }

  Future<Response<T>> delete<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return excuteRequest(() => _dio.delete(url,
        cancelToken: cancelToken,
        data: data,
        options: options,
        queryParameters: queryParameters));
  }

  Future<Response<T>> excuteRequest<T>(
      Future<Response<T>> Function() action) async {
    try {
      final response = await action();
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  ErrorResponse handleError(dynamic error) {
    if (error is DioException) {
      return ErrorResponse(message: 'Network error!');
    } else {
      return ErrorResponse(message: error.toString());
    }
  }
}
