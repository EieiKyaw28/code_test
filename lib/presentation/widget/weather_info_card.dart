import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/common/common_text_style.dart';
import 'package:sky_cast_weather/common/extension.dart';
import 'package:sky_cast_weather/theme/weather_theme.dart';

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
            color: Colors.white,
            width: 30,
            height: 30,
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .slideX(begin: -0.2, end: 0.2, duration: 1.5.seconds),
          8.vGap,
          Text(value, style: CommonTextStyle.text),
          5.vGap,
          Text(
            label,
            style: CommonTextStyle.smallText,
          ),
        ],
      ),
    );
  }
}
