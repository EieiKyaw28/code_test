import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_cast_weather/domain/city_weather_forecast_model.dart';
import 'package:sky_cast_weather/domain/common_query_model.dart';
import 'package:sky_cast_weather/domain/search_cities_response.dart';
import 'package:sky_cast_weather/repository/weather_api_repository.dart';

final searchCitiesProvider = FutureProvider.family<List<CityData>, CommonQueryModel>((ref, query) async {
  final weatherApiRepository = ref.watch(weatherApiRepositoryProvider);
  return weatherApiRepository.searchCities(query: query.city ?? '');
});

final cityWeatherDetailProvider = FutureProvider.family<WeatherResponse, CommonQueryModel>((ref, query) async {
  final weatherApiRepository = ref.watch(weatherApiRepositoryProvider);
  return weatherApiRepository.fetchCityWeatherDetail(lat: query.lat, lon: query.lon, city: query.city);
});

final cityWeatherForecastProvider = FutureProvider.family<WeatherResponse, String>((ref, city) async {
  final weatherApiRepository = ref.watch(weatherApiRepositoryProvider);
  return weatherApiRepository.fetchCityWeatherCast(city: city);
});