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
import 'package:sky_cast_weather/presentation/widget/forecast_detail_card.dart';
import 'package:sky_cast_weather/presentation/widget/toggle_component.dart';
import 'package:sky_cast_weather/presentation/widget/weather_info_card.dart';
import 'package:sky_cast_weather/presentation/widget/weekly_forecast_card.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';
import 'package:sky_cast_weather/theme/weather_theme.dart';
import '../service/location_service.dart';

class CityDetailDesktopView extends ConsumerStatefulWidget {
  const CityDetailDesktopView({
    super.key,
  });

  @override
  ConsumerState<CityDetailDesktopView> createState() =>
      _CityDetailDesktopViewState();
}

class _CityDetailDesktopViewState extends ConsumerState<CityDetailDesktopView> {
  bool isSearchActive = false;

  double? lat;
  double? lon;
  int selectedIndex = -1;
  bool isCelsius = true;
  int selectedToggleIndex = 0;

  void getCurrentLatLon(BuildContext context) async {
    final position = await LocationService().getCurrentLocation(context);
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  void fetchWeather() async {
    if (lat != null && lon != null) {
      final family = CommonQueryModel(
        lat: lat,
        lon: lon,
      );
      final weather = await ref.read(cityWeatherDetailProvider(family).future);
      final weatherCondition =
          getWeatherCategory(weather.current?.condition?.code);
      updateWeatherTheme(weatherCondition.name);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentLatLon(context);
      fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final family = CommonQueryModel(
      lat: lat,
      lon: lon,
    );
    final weatherTheme = Theme.of(context).extension<WeatherTheme>()!;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  weatherTheme.backgroundImage ?? "",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SearchScreen(
                      onSearch: (v) {
                        setState(() {
                          lat = v.lat;
                          lon = v.lon;
                        });
                        fetchWeather();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: lat != null && lon != null
                                  ? AsyncValueWidget(
                                      data: ref.watch(
                                          cityWeatherDetailProvider(family)),
                                      child: (data) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            10.vGap,

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.location?.name ??
                                                      'Unknown City',
                                                  style:
                                                      CommonTextStyle.cityTitle,
                                                ),
                                                ToggleComponent(
                                                  onTap: (index) {
                                                    setState(() {
                                                      selectedToggleIndex =
                                                          index;
                                                      isCelsius = !isCelsius;
                                                    });
                                                  },
                                                  selectedValue:
                                                      selectedToggleIndex,
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
                                                Text(
                                                  data.current?.condition
                                                          ?.text ??
                                                      '',
                                                  style: CommonTextStyle
                                                      .weatherSubtitle,
                                                ),
                                                CatchedNetworkImage(
                                                  url: data.current?.condition
                                                          ?.icon ??
                                                      "",
                                                )
                                                    .animate(
                                                        onPlay: (c) => c.repeat(
                                                            reverse: true))
                                                    .fade(duration: 1.seconds),
                                              ],
                                            ),

                                            // Temperature
                                            Text(
                                              "${isCelsius ? data.current?.tempC?.toString() ?? '-' : data.current?.tempF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'}",
                                              style:
                                                  CommonTextStyle.weatherTitle,
                                            ),

                                            // Daily Summary
                                            10.vGap,
                                            const Text("Daily Summary",
                                                style: CommonTextStyle
                                                    .weatherSubtitle),
                                            5.hGap,
                                            Text(
                                              "It feel like ${isCelsius ? data.current?.feelslikeC?.toString() ?? '-' : data.current?.feelslikeF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'} Today.",
                                              style: CommonTextStyle.text,
                                            ),

                                            20.vGap,
                                            // Weather details (Wind, Humidity, Visibility)
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                    image:
                                                        AssetsString.humidity,
                                                  ),
                                                  WeatherInfoCard(
                                                    label: "Visibility",
                                                    value:
                                                        "${data.current?.visKm.toString() ?? ''}km",
                                                    image:
                                                        AssetsString.visiblity,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(height: 20),

                                            // Weekly forecast (Animated)
                                            const Text(
                                              "Weekly forecast",
                                              style: CommonTextStyle
                                                  .weatherSubtitle,
                                            ),
                                            10.vGap,
                                            if (data.location?.name !=
                                                null) ...[
                                              if (lat != null &&
                                                  lon != null) ...[
                                                AsyncValueWidget(
                                                    data: ref.watch(
                                                        cityWeatherForecastProvider(
                                                      family,
                                                    )),
                                                    child: (data) {
                                                      final forecasts = data
                                                              .forecast
                                                              ?.forecastday ??
                                                          [];
                                                      return SizedBox(
                                                        height: 130,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              forecasts.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final item =
                                                                forecasts[
                                                                    index];
                                                            return WeeklyForecastCard(
                                                              forecast: item,
                                                              isCelsius:
                                                                  isCelsius,
                                                            )
                                                                .animate()
                                                                .fadeIn(
                                                                    duration:
                                                                        500.ms,
                                                                    delay: (index *
                                                                            200)
                                                                        .ms)
                                                                .slideY(
                                                                    begin: 1,
                                                                    end: 0);
                                                          },
                                                        ),
                                                      );
                                                    })
                                              ]
                                            ],
                                          ],
                                        );
                                      })
                                  : const SizedBox(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SafeArea(
                      child: Stack(
                        children: [
                          if (lat != null && lon != null) ...[
                            AsyncValueWidget(
                                data: ref
                                    .watch(cityWeatherForecastProvider(family)),
                                child: (data) {
                                  return CustomScrollView(
                                    slivers: [
                                      SliverPadding(
                                        padding: const EdgeInsets.all(16.0),
                                        sliver: SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6),
                                                  child: SizedBox(
                                                      child: ForecastDetailCard(
                                                    isCelcius: isCelsius,
                                                    selectedIndex: index,
                                                    isSelected:
                                                        selectedIndex == index,
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIndex = index;
                                                      });
                                                    },
                                                    forecast: data.forecast!
                                                        .forecastday![index],
                                                  )));
                                            },
                                            childCount: data
                                                .forecast?.forecastday?.length,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ]
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
