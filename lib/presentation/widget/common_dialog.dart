import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast_weather/common/assets_string.dart';

class CommonDialog extends StatelessWidget {
  final String message;
  final String confirmText;
  final String cancelText;
  final String lottie;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CommonDialog({
    super.key,
    required this.message,
    required this.lottie,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: SizedBox(
        height: 100,
        width: 100,
        child: Lottie.asset(lottie),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      actions: [
        if (onCancel != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel!();
            },
            child: Text(cancelText),
          ),
        InkWell(
          onTap: () {
            if (onConfirm != null) onConfirm!();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(confirmText),
            ),
          ),
        ),
      ],
    );
  }
}
