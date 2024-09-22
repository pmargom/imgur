import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imgur/core/extensions/datetime_extension.dart';
import 'package:imgur/core/network/constants.dart';
import 'package:logging/logging.dart';

class AppInterceptors extends Interceptor {
  static final Logger _logger = Logger("Http Client Interceptor");

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _logger.info('(${DateTime.now().forLoggin}) REQUEST[${options.method}] => PATH: ${options.uri}');

    if (kDebugMode) {
      _logger.warning("clientId -> $clientId");
      options.headers["Authorization"] = "Client-ID $clientId";
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info('(${DateTime.now().forLoggin}) RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.info('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    try {
      if (err.response?.statusCode == 401) {
        // TODO: refresh token
      }
    } catch (e) {
      // TODO: logout
    }

    return super.onError(err, handler);
  }
}
