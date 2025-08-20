import 'package:flutter/material.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/common/extension.dart';

class WeatherTheme extends ThemeExtension<WeatherTheme> {
  final String? backgroundImage;
  final ColorScheme colorScheme;

  const WeatherTheme({
    this.backgroundImage,
    required this.colorScheme,
  });

  @override
  WeatherTheme copyWith({String? backgroundImage, ColorScheme? colorScheme}) {
    return WeatherTheme(
      backgroundImage: backgroundImage ?? this.backgroundImage,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  WeatherTheme lerp(ThemeExtension<WeatherTheme>? other, double t) {
    if (other is! WeatherTheme) return this;
    return this;
  }
}

final defaultTheme = WeatherTheme(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.light,
  ),
);

final sunnyTheme = WeatherTheme(
  backgroundImage: isMobile ? AssetsString.sunny : AssetsString.sunnyDk,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.light,
  ),
);

final rainyTheme = WeatherTheme(
  backgroundImage: isMobile ? AssetsString.rain : AssetsString.rainyDk,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueGrey,
    brightness: Brightness.dark,
  ),
);
final mistTheme = WeatherTheme(
  backgroundImage: AssetsString.mist,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueGrey,
    brightness: Brightness.dark,
  ),
);
final cloudyTheme = WeatherTheme(
  backgroundImage: isMobile ? AssetsString.cloudy : AssetsString.cloudyDk,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
);

WeatherCategory getWeatherCategory(int code) {
  switch (code) {
    // Clear / Sunny
    case 1000:
      return WeatherCategory.clear;

    // Partly cloudy
    case 1003:
      return WeatherCategory.partlyCloudy;

    // Cloudy / Overcast
    case 1006:
    case 1009:
      return WeatherCategory.cloudy;

    // Mist / Fog / Haze
    case 1030:
    case 1135:
    case 1147:
      return WeatherCategory.mist;

    // Rain / Showers
    case 1063:
    case 1150:
    case 1153:
    case 1180:
    case 1183:
    case 1186:
    case 1189:
    case 1192:
    case 1195:
    case 1240:
    case 1243:
    case 1246:
      return WeatherCategory.rain;

    // Thunderstorms
    case 1087:
    case 1273:
    case 1276:
    case 1279:
    case 1282:
      return WeatherCategory.thunder;

    // Snow / Ice / Sleet
    case 1066:
    case 1069:
    case 1072:
    case 1114:
    case 1117:
    case 1210:
    case 1213:
    case 1216:
    case 1219:
    case 1222:
    case 1225:
    case 1237:
    case 1249:
    case 1252:
    case 1255:
    case 1258:
    case 1261:
    case 1264:
      return WeatherCategory.snow;

    // Extreme (blizzard, tornado, hurricane, etc.)
    case 1201:
    case 1204:
    case 1207:
      return WeatherCategory.extreme;

    default:
      return WeatherCategory.clear;
  }
}

enum WeatherCategory {
  clear,
  partlyCloudy,
  cloudy,
  mist,
  rain,
  thunder,
  snow,
  extreme,
}

final currentWeatherTheme = ValueNotifier<WeatherTheme>(rainyTheme);

void updateWeatherTheme(String condition) {
  condition = condition.toLowerCase();
  if (condition.contains(WeatherCategory.clear.name)) {
    currentWeatherTheme.value = sunnyTheme;
  } else if (condition.contains(WeatherCategory.rain.name) ||
      condition.contains(WeatherCategory.thunder.name)) {
    currentWeatherTheme.value = rainyTheme;
  } else if (condition.contains(WeatherCategory.mist.name)) {
    currentWeatherTheme.value = rainyTheme;
  } else if (condition.contains(WeatherCategory.cloudy.name) ||
      condition.contains(WeatherCategory.partlyCloudy.name)) {
    currentWeatherTheme.value = cloudyTheme;
  } else {
    currentWeatherTheme.value = rainyTheme;
  }
}
