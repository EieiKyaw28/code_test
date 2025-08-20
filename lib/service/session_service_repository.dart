import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/service/custom_response.dart';

import 'package:sky_cast_weather/service/session_constant.dart';
import 'package:sky_cast_weather/service/session_service.dart';

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



