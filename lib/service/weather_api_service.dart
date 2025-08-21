import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart';
import 'package:sky_cast_weather/domain/search_cities_response.dart';
import 'package:sky_cast_weather/env.dart';
import 'session_service.dart';

// WeatherApiService is for low-level API calls related to weather data.
// It uses SessionService to make HTTP requests and handles the response.
class WeatherApiService {
  WeatherApiService(this.session);

  final SessionService session;

  //! search
  Future<List<CityData>> searchCities({required String query}) async {
    try {
      final url = '${Env.baseUrl}/search.json?key=${Env.key}&q=$query';
      final response = await session.get(url);

      final data = response.data;

      return cityDataFromJson(json.encode(data));
    } catch (e) {
      rethrow;
    }
  }

  //! by geolocation or city name
  Future<WeatherResponse> fetchCityWeatherDetail({
    required double lat,
    required double lon,
  }) async {
    try {

      final url = '${Env.baseUrl}/current.json?key=${Env.key}&q=$lat,$lon';
      final response = await session.get(url);

      final data = response.data;
      return WeatherResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  //! 5 days forecast
  Future<WeatherResponse> fetchCityWeatherForecast({
    required double? lat,
    required double? lon,
  }) async {
    try {
      final url = '${Env.baseUrl}/forecast.json?key=${Env.key}&q=$lat,$lon&days=5';
      final response = await session.get(url);

      final data = response.data;
      return WeatherResponse.fromJsonForcecastOnly(data);
    } catch (e) {
      rethrow;
    }
  }
}

final weatherApiServiceProvider = Provider<WeatherApiService>(
  (ref) => WeatherApiService(ref.watch(sessionServiceProvider)),
);
