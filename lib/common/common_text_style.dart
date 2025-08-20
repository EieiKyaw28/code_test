import 'package:flutter/material.dart';

class CommonTextStyle {
  static const TextStyle weatherTitle = TextStyle(
    fontSize: 90,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 4.0,
        color: Colors.black,
      ),
    ],
  );

  static const TextStyle cityTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 4.0,
        color: Colors.black,
      ),
    ],
  );

  static const TextStyle weatherSubtitle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ],
  );

  static const TextStyle text = TextStyle(
    fontSize: 14,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ],
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ],
  );
}
