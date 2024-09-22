import 'package:dio/dio.dart';
import 'package:imgur/core/network/constants.dart';
import 'package:imgur/core/network/interceptors.dart';

class ServicesBaseApi {
  final Dio _dio = Dio();

  ServicesBaseApi() {
    _dio.interceptors.add(AppInterceptors());
    _dio.options.baseUrl = apiBaseUrlWithVersion;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters);
      final responseJson = response.data;

      return responseJson;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters);
      final responseJson = response.data;

      return responseJson;
    } catch (e) {
      rethrow;
    }
  }
}
