import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/presentation/widget/common_dialog.dart';
import 'package:sky_cast_weather/service/custom_exception.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.data,
      required this.child,
      this.loadingChild,
      this.errorChild,
      this.onConfirm});

  final AsyncValue<T> data;
  final Widget Function(T) child;
  final Widget? loadingChild;
  final Widget Function()? errorChild;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return data.when(
        data: (data) => child(data),
        error: (e, s) {
          log("async value widget error ->  ${e.toString()} error runtimetype > ${e.runtimeType}   stack trace -> ${s.toString()}");

          return errorChild != null
              ? errorChild!()
              : _CommonErrorWidget(
                  exception: e as CustomException,
                  onRetry: onConfirm,
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
  const _CommonErrorWidget(
      {super.key, required this.exception, required this.onRetry});

  final CustomException exception;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    switch (exception) {
      case NoInternetConnectionException:
        return CommonDialog(
          lottie: AssetsString.noInternet,
          message: exception.message,
          confirmText: "Retry",
          onConfirm: onRetry,
        );

      case InternalServerErrorException:
        return CommonDialog(
          lottie: AssetsString.error,
          message: exception.message,
          confirmText: "Retry",
          onConfirm: onRetry,
        );

      case ConnectionTimeoutException:
        return CommonDialog(
          lottie: AssetsString.error,
          message: exception.message,
          confirmText: "Retry",
          onConfirm: onRetry,
        );

      default:
        return CommonDialog(
          lottie: AssetsString.error,
          message: exception.message,
          confirmText: "OK",
          onConfirm: () => Navigator.of(context).pop(),
        );
    }
  }
}
