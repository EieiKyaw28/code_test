import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast_weather/common/extension.dart';

class CommonDialog extends StatelessWidget {
  final String message;
  final String confirmText;
  final String cancelText;
  final String lottie;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isLoading;

  const CommonDialog({
    super.key,
    required this.message,
    required this.lottie,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: SizedBox(
        height: 100,
        width: 100,
        child: Lottie.asset(lottie),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          20.vGap,
          InkWell(
            onTap: isLoading
                ? null
                : () async { 
                    try {
                      onConfirm?.call();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Something went wrong, please try again.")),
                        );
                      }
                    }  
                  },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.black)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Retry",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
