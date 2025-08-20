import 'package:flutter/material.dart';

import 'package:sky_cast_weather/common/extension.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart'
    hide Text;

class HourlyForcastCard extends StatelessWidget {
  final Current forecast;
  final bool isCelsius;
  final String time;

  const HourlyForcastCard(
      {super.key,
      required this.forecast,
      required this.isCelsius,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(isCelsius ? "${forecast.tempC}°C" : "${forecast.tempF}°F",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              )),
          5.vGap,
          Text(time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
