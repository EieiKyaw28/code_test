import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/service/custom_exception.dart';
import 'package:sky_cast_weather/service/custom_response.dart';
import 'package:sky_cast_weather/service/session_service_repository.dart';

abstract class SessionService {
  Future<CustomResponse> get(String url, {Map<String, String>? headers});
}

class SessionServiceImpl implements SessionService {
  Dio dio;

  SessionServiceImpl(this.dio);

  @override
  Future<CustomResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 20));

      log(" url : $url\nresponse: ${response.data}\nstatusCode: ${response.statusCode}");

      final customeResponse = CustomResponse(
        data: response.data,
        statusCode: response.statusCode!,
      );

      return _handleResponse(customeResponse, url);
    } on DioException catch (_) {
      final dioException = _;

      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.sendTimeout ||
          dioException.type == DioExceptionType.receiveTimeout) {
        log("Connection timeout: $url");
        throw ConnectionTimeoutException();
      } else if (dioException.type == DioExceptionType.badResponse) {
        log("Bad response: ${dioException.response?.statusCode} - ${dioException.response?.data}");
        throw CustomException(dioException.message ?? '',
            statusCode: dioException.response?.statusCode);
      } else if (dioException.type == DioExceptionType.connectionError) {
        log("Connection error: $url");
        throw NoInternetConnectionException();
      } else {
        log("Dio error: ${dioException.message}");
        throw CustomException(dioException.message ?? 'Unknown Dio error',
            statusCode: dioException.response?.statusCode);
      }
    } on TimeoutException catch (_) {
      log("Timeout exception: $url");
      throw ConnectionTimeoutException();
    } on SocketException catch (_) {
      log("Timeout exception: $url");
      throw NoInternetConnectionException();
    } catch (e, st) {
      log("Unexpected error: $e $st");
      throw CustomException("An unexpected error occurred");
    }
  }

  CustomResponse _handleResponse(CustomResponse response, String url) {
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else if (response.statusCode == 500) {
      throw InternalServerErrorException();
    } else {
      log("Error: ${response.statusCode} - ${response.data}");
      throw CustomException(response.data.toString(),
          statusCode: response.statusCode);
    }
  }
}

final sessionServiceProvider = Provider<SessionService>(
  (ref) => SessionServiceImpl(ref.watch(dioProvider)),
);
