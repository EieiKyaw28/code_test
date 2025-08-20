import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_cast_weather/common/common_text_style.dart';
import 'package:sky_cast_weather/common/extension.dart';

class WeatherInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String image;

  const WeatherInfoCard({
    super.key,
    required this.label,
    required this.value,
    this.image = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 100,
      child: Column(
        children: [
          Image.asset(
            image,
            color: Colors.black,
            width: 30,
            height: 30,
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .slideX(begin: -0.2, end: 0.2, duration: 1.5.seconds),
          8.vGap,
          Text(value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Colors.grey,
                  ),
                ],
              )),
          5.vGap,
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
