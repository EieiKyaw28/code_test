import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/service/utils/custom_exception.dart';
import 'package:sky_cast_weather/domain/custom_response.dart';
import 'package:sky_cast_weather/provider/dio_provider.dart';

abstract class SessionService {
  Future<CustomResponse> get(String url, {Map<String, String>? headers});
}

class SessionServiceImpl implements SessionService {
  Dio dio;

  SessionServiceImpl(this.dio);

  @override
  Future<CustomResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 30));

      final customeResponse = CustomResponse(
        data: response.data,
        statusCode: response.statusCode!,
      );

      return _handleResponse(customeResponse, url);
    } on TimeoutException catch (_) {
      throw ConnectionTimeoutException();
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioException catch (_) {
      final dioException = _;

      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.sendTimeout ||
          dioException.type == DioExceptionType.receiveTimeout) {
        throw ConnectionTimeoutException();
      } else if (dioException.type == DioExceptionType.badResponse) {
        throw CustomException(dioException.message ?? '',
            statusCode: dioException.response?.statusCode);
      } else if (dioException.type == DioExceptionType.connectionError) {
        throw NoInternetConnectionException();
      } else {
        throw CustomException(dioException.message ?? 'Something went wrong',
            statusCode: dioException.response?.statusCode);
      }
    } catch (e) {
      throw CustomException("An unexpected error occurred");
    }
  }

  CustomResponse _handleResponse(CustomResponse response, String url) {
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else if (response.statusCode == 500) {
      throw InternalServerErrorException();
    } else {
      throw CustomException(response.data.toString(),
          statusCode: response.statusCode);
    }
  }
}

final sessionServiceProvider = Provider<SessionService>(
  (ref) => SessionServiceImpl(ref.watch(dioProvider)),
);
