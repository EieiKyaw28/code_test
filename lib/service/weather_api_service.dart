import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart';
import 'package:sky_cast_weather/domain/search_cities_response.dart';
import 'package:sky_cast_weather/service/session_constant.dart';
import 'session_service.dart';

// WeatherApiService is for low-level API calls related to weather data.
// It uses SessionService to make HTTP requests and handles the response.
class WeatherApiService {
  WeatherApiService(this.session);

  final SessionService session;

  //! search
  Future<List<CityData>> searchCities({required String query}) async {
    try {
      final url = '$baseUrl/search.json?key=$kApiKey&q=$query';
      final response = await session.get(url);

      final data = response.data;

      return cityDataFromJson(json.encode(data));
    } catch (e, st) {
      log("Search Cities Error: $e $st");
      rethrow;
    }
  }

  //! by geolocation or city name
  Future<WeatherResponse> fetchCityWeatherDetail(
      {required double lat,
      required double lon,}) async {
    try {
      log("Lat Lon in fetchCityWeatherDetail : $lat, $lon");

      final url = '$baseUrl/current.json?key=$kApiKey&q=$lat,$lon';
      final response = await session.get(url);

      final data = response.data;
      return WeatherResponse.fromJson(data);
    } catch (e, st) {
      log("Fetch City Weather by Name Error: $e $st");
      rethrow;
    }
  }

  //! 5 days forecast
  Future<WeatherResponse> fetchCityWeatherForecast({
    required double? lat,
    required double? lon,
  }) async {
    try {
      log("Lat Lon in fetchCityWeatherForecast : $lat, $lon");
      final url = '$baseUrl/forecast.json?key=$kApiKey&q=$lat,$lon&days=5';
      log(" fetchCityWeatherForecast url > $url  ");
      final response = await session.get(url);

      final data = response.data;
      return WeatherResponse.fromJsonForcecastOnly(data);
    } catch (e, st) {
      log("Fetch City Weather by Name Error: $e $st");
      rethrow;
    }
  }
}

final weatherApiServiceProvider = Provider<WeatherApiService>(
  (ref) => WeatherApiService(ref.watch(sessionServiceProvider)),
);
