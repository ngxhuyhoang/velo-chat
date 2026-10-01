import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.options.baseUrl = "";

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (options, handler) {
        return handler.next(options);
      },
      onError: (options, handler) {
        return handler.next(options);
      },
    ),
  );

  return dio;
});
