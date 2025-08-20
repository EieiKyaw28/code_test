import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/presentation/city_detail_screen.dart';
import 'package:sky_cast_weather/theme/weather_theme.dart';
import 'package:sky_cast_weather/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<WeatherTheme>(
      valueListenable: currentWeatherTheme,
      builder: (context, weatherTheme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            extensions: [weatherTheme],
            colorScheme: weatherTheme.colorScheme,
          ),
          home: const CityDetailScreen(),
        );
      },
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: appTheme,
    //   home: const CityDetailScreen(),
    // );
  }
}
