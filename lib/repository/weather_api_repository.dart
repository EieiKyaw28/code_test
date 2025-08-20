import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart';
import 'package:sky_cast_weather/domain/search_cities_response.dart';
import 'package:sky_cast_weather/service/weather_api_service.dart';

// WeatherRepository is a high-level repository that interacts with the WeatherApiService
// It abstracts the data fetching logic and provides a clean API for the rest of the application.
class WeatherRepository {
  final WeatherApiService weatherApiService;

  WeatherRepository({required this.weatherApiService});

  Future<List<CityData>> searchCities({required String query}) async {
    try {
      final response = await weatherApiService.searchCities(query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherResponse> fetchCityWeatherDetail({required double? lat, required double? lon, required String? city}) async {
    try {
      final response = await weatherApiService.fetchCityWeatherDetail(city: city, lat: lat, lon: lon);
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<WeatherResponse> fetchCityWeatherCast({required String city}) async {
    try {
      final response = await weatherApiService.fetchCityWeatherForecast(city: city);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

final weatherApiRepositoryProvider = Provider<WeatherRepository>(
  (ref) => WeatherRepository(weatherApiService: ref.watch(weatherApiServiceProvider)),
);
