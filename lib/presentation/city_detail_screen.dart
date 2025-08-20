import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/common/common_text_style.dart';
import 'package:sky_cast_weather/common/extension.dart';
import 'package:sky_cast_weather/domain/common_query_model.dart';
import 'package:sky_cast_weather/presentation/search_sceen.dart';
import 'package:sky_cast_weather/presentation/widget/async_value_widget.dart';
import 'package:sky_cast_weather/presentation/widget/catched_network_image.dart';
import 'package:sky_cast_weather/presentation/widget/common_dialog.dart';
import 'package:sky_cast_weather/presentation/widget/toggle_component.dart';
import 'package:sky_cast_weather/presentation/widget/weather_info_card.dart';
import 'package:sky_cast_weather/presentation/widget/weekly_forecast_card.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';
import 'package:sky_cast_weather/theme/weather_theme.dart';
import 'package:sky_cast_weather/theme_data.dart';
import 'package:lottie/lottie.dart';

import '../service/location_service.dart';

class CityDetailScreen extends ConsumerStatefulWidget {
  const CityDetailScreen({
    super.key,
    this.cityName,
  });

  final String? cityName;

  @override
  ConsumerState<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends ConsumerState<CityDetailScreen> {
  bool isSearchActive = false;

  double? lat;
  double? lon;
  int selectedIndex = 0;
  bool isCelsius = true;

  void getCurrentLatLon() async {
    if (widget.cityName == null) {
      final position = await LocationService().getCurrentLocation();
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
      });
    }
  }

  void fetchWeather() async {
    final family = CommonQueryModel(
      lat: lat,
      lon: lon,
      city: widget.cityName,
    );

    final weather = await ref.read(cityWeatherDetailProvider(family).future);
    final weatherCondition =
        getWeatherCategory(weather.current?.condition?.code);
    updateWeatherTheme(weatherCondition.name);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLatLon();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final family = CommonQueryModel(
      lat: lat,
      lon: lon,
      city: widget.cityName,
    );
    final weatherTheme = Theme.of(context).extension<WeatherTheme>()!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Image.asset(
                weatherTheme.backgroundImage ?? "",
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widget.cityName == null && lat == null && lon == null
                        ? SizedBox(
                            child: Center(
                              child: Lottie.asset(AssetsString.loading),
                            ),
                          )
                        : AsyncValueWidget(
                            loadingChild: const SizedBox(),
                            onConfirm: () {
                              ref.invalidate(cityWeatherDetailProvider);
                            },
                            data: ref.watch(cityWeatherDetailProvider(family)),
                            child: (data) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.vGap,

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data.location?.name ??
                                                'Unknown City',
                                            style: CommonTextStyle.cityTitle,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SearchScreen(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ToggleComponent(
                                        onTap: (index) {
                                          setState(() {
                                            selectedIndex = index;
                                            isCelsius = !isCelsius;
                                          });
                                        },
                                        selectedValue: selectedIndex,
                                      ),
                                    ],
                                  ),

                                  Text(
                                    data.location?.localtime ?? "",
                                    style: CommonTextStyle.text,
                                  ),
                                  5.vGap,

                                  // Weather condition
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.current?.condition?.text ?? '',
                                          style:
                                              CommonTextStyle.weatherSubtitle,
                                        ),
                                      ),
                                      CatchedNetworkImage(
                                        url:
                                            data.current?.condition?.icon ?? "",
                                      )
                                          .animate(
                                              onPlay: (c) =>
                                                  c.repeat(reverse: true))
                                          .fade(duration: 1.seconds),
                                    ],
                                  ),

                                  // Temperature
                                  Text(
                                    "${isCelsius ? data.current?.tempC?.toString() ?? '-' : data.current?.tempF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'}",
                                    style: CommonTextStyle.weatherTitle,
                                  ),

                                  // Daily Summary
                                  10.vGap,
                                  const Text("Daily Summary",
                                      style: CommonTextStyle.weatherSubtitle),
                                  5.hGap,
                                  Text(
                                    "It feel like ${isCelsius ? data.current?.feelslikeC?.toString() ?? '-' : data.current?.feelslikeF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'} Today.",
                                    style: CommonTextStyle.text,
                                  ),

                                  20.vGap,
                                  // Weather details (Wind, Humidity, Visibility)
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        WeatherInfoCard(
                                          label: "Wind",
                                          value:
                                              "${data.current?.windKph.toString() ?? ''}km/h",
                                          image: AssetsString.wind,
                                        ),
                                        WeatherInfoCard(
                                          label: "Humidity",
                                          value:
                                              "${data.current?.humidity.toString() ?? ''}%",
                                          image: AssetsString.humidity,
                                        ),
                                        WeatherInfoCard(
                                          label: "Visibility",
                                          value:
                                              "${data.current?.visKm.toString() ?? ''}km",
                                          image: AssetsString.visiblity,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Weekly forecast (Animated)
                                  const Text(
                                    "Weekly forecast",
                                    style: CommonTextStyle.weatherSubtitle,
                                  ),
                                  10.vGap,
                                  if (data.location?.name != null) ...[
                                    AsyncValueWidget(
                                        data: ref.watch(
                                            cityWeatherForecastProvider(
                                                data.location!.name!)),
                                        child: (data) {
                                          final forecasts =
                                              data.forecast?.forecastday ?? [];
                                          return SizedBox(
                                            height: 100,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: forecasts.length,
                                              itemBuilder: (context, index) {
                                                final item = forecasts[index];
                                                return WeeklyForecastCard(
                                                  forecast: item,
                                                  isCelsius: isCelsius,
                                                )
                                                    .animate()
                                                    .fadeIn(
                                                        duration: 500.ms,
                                                        delay: (index * 200).ms)
                                                    .slideY(begin: 1, end: 0);
                                              },
                                            ),
                                          );
                                        })
                                  ],
                                ],
                              );
                            })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
