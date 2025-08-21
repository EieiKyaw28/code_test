import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/presentation/widget/common_dialog.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';
import 'package:sky_cast_weather/service/utils/custom_exception.dart';

class AsyncValueWidget<T> extends ConsumerWidget {
  const AsyncValueWidget(
      {super.key, required this.data, required this.child, this.loadingChild});

  final AsyncValue<T> data;
  final Widget Function(T) child;
  final Widget? loadingChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return data.when(
        data: (data) => child(data),
        error: (e, s) {
          return _CommonErrorWidget(
            exception: e as CustomException,
            onRetry: () {
              try {
                ref.invalidate(cityWeatherDetailProvider);
                ref.invalidate(searchCitiesProvider);
                ref.invalidate(cityWeatherForecastProvider);
              } catch (e) {
                rethrow;
              }
            },
            isLoading: data.isLoading || data.isRefreshing || data.isReloading,
          );
        },
        loading: () {
          return loadingChild ??
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
        });
  }
}

class _CommonErrorWidget extends StatelessWidget {
  const _CommonErrorWidget({
    required this.exception,
    required this.onRetry,
    required this.isLoading,
  });

  final CustomException exception;
  final VoidCallback onRetry;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (exception is NoInternetConnectionException) {
      return CommonDialog(
        lottie: AssetsString.noInternet,
        message: exception.message,
        confirmText: "Retry",
        onConfirm: onRetry,
        isLoading: isLoading,
      );
    } else if (exception is InternalServerErrorException) {
      return CommonDialog(
        lottie: AssetsString.error,
        message: exception.message,
        confirmText: "Retry",
        onConfirm: onRetry,
        isLoading: isLoading,
      );
    } else if (exception is ConnectionTimeoutException) {
      return CommonDialog(
        lottie: AssetsString.noInternet,
        message: exception.message,
        confirmText: "Retry",
        onConfirm: onRetry,
        isLoading: isLoading,
      );
    } else {
      return CommonDialog(
        lottie: AssetsString.error,
        message: exception.message,
        confirmText: "Retry",
        onConfirm: onRetry,
        isLoading: isLoading,
      );
    }
  }
}
