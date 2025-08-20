import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/domain/common_query_model.dart';

import 'package:sky_cast_weather/presentation/widget/async_value_widget.dart';
import 'package:sky_cast_weather/presentation/widget/forecast_detail_card.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';
import 'package:sky_cast_weather/theme/weather_theme.dart';

class ForecastDetailScreen extends ConsumerStatefulWidget {
  const ForecastDetailScreen(
      {super.key,
      required this.lat,
      required this.lon,
      required this.isCelcius});
  final double lat;
  final double lon;
  final bool isCelcius;

  @override
  ConsumerState<ForecastDetailScreen> createState() =>
      _ForecastDetailScreenState();
}

class _ForecastDetailScreenState extends ConsumerState<ForecastDetailScreen> {
  int selectedIndex = -1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherTheme = Theme.of(context).extension<WeatherTheme>()!;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Weekly Forecast",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
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
              AsyncValueWidget(
                  onConfirm: () async {
                    await ref.read(cityWeatherForecastProvider(
                        CommonQueryModel(lat: widget.lat, lon: widget.lon))
                        .future);
                  },
                  data: ref.watch(cityWeatherForecastProvider(
                      CommonQueryModel(lat: widget.lat, lon: widget.lon))),
                  child: (data) {
                    return CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: SizedBox(
                                        child: ForecastDetailCard(
                                      isCelcius: widget.isCelcius,
                                      selectedIndex: index,
                                      isSelected: selectedIndex == index,
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      forecast:
                                          data.forecast!.forecastday![index],
                                    )));
                              },
                              childCount: data.forecast?.forecastday?.length,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
