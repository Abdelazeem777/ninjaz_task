import 'dart:async';

import 'package:dio/dio.dart';
import '../exceptions/connection_exception.dart';
import '../exceptions/request_exception.dart';

abstract class NetworkService {
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  });

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  });
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl();

  final _dio = Dio(BaseOptions(
      headers: {'app-id': '65eb2bc3787b68499879a7e1'},
      validateStatus: (_) => true));

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  }) {
    return _connectionExceptionCatcher(() => _get(
          url,
          queryParameters: queryParameters,
          headers: headers,
          responseType: responseType,
        ));
  }

  @override
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  }) {
    return _connectionExceptionCatcher(() => _post(
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers,
          responseType: responseType,
        ));
  }

  Future<Response> _get(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  }) async {
    Future<Response> requestCallback(Map<String, dynamic>? headers) async =>
        _dio.get(
          apiBaseUrl,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            responseType: responseType,
          ),
        );

    var response = await requestCallback(headers);

    if ([401, 403].contains(response.statusCode))
      throw RequestException('Unauthorized');

    return response;
  }

  Future<Response> _post(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
  }) async {
    Future<Response> requestCallback(Map<String, dynamic>? headers) async =>
        _dio.post(
          apiBaseUrl,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            headers: headers,
            responseType: responseType,
          ),
        );

    var response = await requestCallback(headers);

    if ([401, 403].contains(response.statusCode))
      throw RequestException('Unauthorized');

    return response;
  }

  Future<T> _connectionExceptionCatcher<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      var message = e.toString();
      if ([
        'SocketException',
        'HttpException',
        'time out',
        'HandshakeException',
        'Failed host lookup'
      ].any((e) => message.contains(e)))
        throw ConnectionException('connection_error');
      rethrow;
    }
  }
}
