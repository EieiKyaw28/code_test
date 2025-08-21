import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      sendTimeout: null,
      receiveTimeout: null,
      validateStatus: (_) => true,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
    ),
  );
});
