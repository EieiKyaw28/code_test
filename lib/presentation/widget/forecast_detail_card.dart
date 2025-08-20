import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:sky_cast_weather/common/common_text_style.dart';
import 'package:sky_cast_weather/common/extension.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart'
    hide Text, Icon;
import 'package:sky_cast_weather/presentation/widget/catched_network_image.dart';
import 'package:sky_cast_weather/presentation/widget/hourly_forcast_card.dart';

class ForecastDetailCard extends StatelessWidget {
  final Forecastday forecast;
  final GestureTapCallback onTap;
  final int selectedIndex;
  final bool isSelected;
  final bool isCelcius;

  const ForecastDetailCard(
      {super.key,
      required this.forecast,
      required this.onTap,
      required this.selectedIndex,
      required this.isSelected,
      required this.isCelcius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSelected ? 200 : null,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  forecast.date != null
                      ? DateFormat("dd MMM yyyy").format(forecast.date!)
                      : "-",
                  style: CommonTextStyle.weatherSubtitle),
              CatchedNetworkImage(
                url: forecast.day?.condition?.icon ?? "",
              ).animate(onPlay: (c) {
                if (isSelected) {
                  c.repeat(reverse: true);
                }
              }).fade(duration: isSelected ? 1.seconds : 0.seconds),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  isCelcius
                      ? "${forecast.day?.avgtempC}°C"
                      : "${forecast.day?.avgtempF}°F",
                  style: CommonTextStyle.cityTitle),
              InkWell(
                onTap: onTap,
                child: const Icon(
                  Icons.expand_circle_down_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          10.vGap,
          if (isSelected)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.hour?.length,
                itemBuilder: (context, index) {
                  final item = forecast.hour?[index];
                  final cleaned = item?.time?.replaceFirstMapped(
                    RegExp(r'(\d{4}-\d{2}-\d{2})(\d{2}:\d{2})'),
                    (m) => "${m[1]} ${m[2]}",
                  );

                  final dateTime = DateTime.parse(cleaned ?? "");

                  final readableTime = DateFormat.jm().format(dateTime);
                  return HourlyForcastCard(
                    forecast: item!,
                    isCelsius: true,
                    time: readableTime,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
