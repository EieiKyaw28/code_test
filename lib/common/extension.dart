import 'package:flutter/material.dart';

extension Size on BuildContext {
  get getWidth => MediaQuery.of(this).size.width;
  get getHeight => MediaQuery.of(this).size.height;
}

extension Gap on num {
  SizedBox get vGap => SizedBox(height: toDouble());
  SizedBox get hGap => SizedBox(width: toDouble());
}
