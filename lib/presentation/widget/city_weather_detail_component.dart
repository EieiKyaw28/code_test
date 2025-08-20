// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sky_cast_weather/common/assets_string.dart';
// import 'package:sky_cast_weather/domain/common_query_model.dart';
// import 'package:sky_cast_weather/presentation/widget/async_value_widget.dart';
// import 'package:sky_cast_weather/provider/weather_api_providers.dart';

// class CityWeatherDetailComponent extends ConsumerWidget {
//   const CityWeatherDetailComponent({
//     super.key,
//     required this.cityName,
//     required this.lat,
//     required this.lon,
//   });
//   final String? cityName;
//   final double? lat;
//   final double? lon;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: cityName == null && lat == null && lon == null
//                 ? SizedBox(
//                     child: Center(
//                       child: Lottie.asset(AssetsString.loading),
//                     ),
//                   )
//                 : AsyncValueWidget(
//                     loadingChild: const SizedBox(),
//                     onConfirm: () {
//                       ref.invalidate(cityWeatherDetailProvider);
//                     },
//                     data: ref.watch(cityWeatherDetailProvider(CommonQueryModel(
//                       city: cityName,
//                       lat: lat,
//                       lon: lon,
//                     ))),
//                     child: (data) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           20.vGap,

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     data.location?.name ?? 'Unknown City',
//                                     style: CommonTextStyle.cityTitle,
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               const SearchScreen(),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.search,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               ToggleComponent(
//                                 onTap: (index) {
//                                   setState(() {
//                                     selectedIndex = index;
//                                     isCelsius = !isCelsius;
//                                   });
//                                 },
//                                 selectedValue: selectedIndex,
//                               ),
//                             ],
//                           ),

//                           Text(
//                             data.location?.localtime ?? "",
//                             style: CommonTextStyle.text,
//                           ),
//                           5.vGap,

//                           // Weather condition
//                           Row(
//                             children: [
//                               Text(
//                                 data.current?.condition?.text ?? '',
//                                 style: CommonTextStyle.weatherSubtitle,
//                               ),
//                               CatchedNetworkImage(
//                                 url: data.current?.condition?.icon ?? "",
//                               )
//                                   .animate(
//                                       onPlay: (c) => c.repeat(reverse: true))
//                                   .fade(duration: 1.seconds),
//                             ],
//                           ),

//                           // Temperature
//                           Text(
//                             "${isCelsius ? data.current?.tempC?.toString() ?? '-' : data.current?.tempF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'}",
//                             style: CommonTextStyle.weatherTitle,
//                           ),

//                           // Daily Summary
//                           10.vGap,
//                           const Text("Daily Summary",
//                               style: CommonTextStyle.weatherSubtitle),
//                           5.hGap,
//                           Text(
//                             "It feel like ${isCelsius ? data.current?.feelslikeC?.toString() ?? '-' : data.current?.feelslikeF?.toString() ?? '-'} ${isCelsius ? '°C' : '°F'} Today.",
//                             style: CommonTextStyle.text,
//                           ),

//                           20.vGap,
//                           // Weather details (Wind, Humidity, Visibility)
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 WeatherInfoCard(
//                                   label: "Wind",
//                                   value:
//                                       "${data.current?.windKph.toString() ?? ''}km/h",
//                                   image: AssetsString.wind,
//                                 ),
//                                 WeatherInfoCard(
//                                   label: "Humidity",
//                                   value:
//                                       "${data.current?.humidity.toString() ?? ''}%",
//                                   image: AssetsString.humidity,
//                                 ),
//                                 WeatherInfoCard(
//                                   label: "Visibility",
//                                   value:
//                                       "${data.current?.visKm.toString() ?? ''}km",
//                                   image: AssetsString.visiblity,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // Weekly forecast (Animated)
//                           const Text(
//                             "Weekly forecast",
//                             style: CommonTextStyle.weatherSubtitle,
//                           ),
//                           10.vGap,
//                           if (data.location?.name != null) ...[
//                             AsyncValueWidget(
//                                 data: ref.watch(cityWeatherForecastProvider(
//                                   family,
//                                 )),
//                                 child: (data) {
//                                   final forecasts =
//                                       data.forecast?.forecastday ?? [];
//                                   return SizedBox(
//                                     height: 130,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: forecasts.length,
//                                       itemBuilder: (context, index) {
//                                         final item = forecasts[index];
//                                         return WeeklyForecastCard(
//                                           forecast: item,
//                                           isCelsius: isCelsius,
//                                         )
//                                             .animate()
//                                             .fadeIn(
//                                                 duration: 500.ms,
//                                                 delay: (index * 200).ms)
//                                             .slideY(begin: 1, end: 0);
//                                       },
//                                     ),
//                                   );
//                                 })
//                           ],
//                         ],
//                       );
//                     })),
//       ],
//     );
//   }
// }
