import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/service/utils/session_constant.dart';

final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      sendTimeout: null,
      receiveTimeout: null,
      validateStatus: (_) => true,
      headers: kHeader,
    ),
  );
});



