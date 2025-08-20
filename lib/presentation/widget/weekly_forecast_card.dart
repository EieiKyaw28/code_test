import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_cast_weather/common/common_text_style.dart';
import 'package:sky_cast_weather/common/extension.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart'
    hide Text;

class WeeklyForecastCard extends StatelessWidget {
  final Forecastday forecast;
  final bool isCelsius;

  const WeeklyForecastCard({
    super.key,
    required this.forecast,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              isCelsius
                  ? "${forecast.day?.avgtempC}°"
                  : "${forecast.day?.avgtempF}°",
              style: CommonTextStyle.text),
          5.vGap,
          Text(
              forecast.date != null
                  ? DateFormat("dd MMM").format(forecast.date!)
                  : "-",
              style: CommonTextStyle.smallText),
        ],
      ),
    );
  }
}
