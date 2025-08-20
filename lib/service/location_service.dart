import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Singleton instance
  static final LocationService _instance = LocationService._internal();

  // Private constructor
  LocationService._internal();

  // Factory constructor returns the same instance
  factory LocationService() => _instance;

  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location services are disabled.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e, st) {
      log(
        " get current location error: $e $st",
      );
      rethrow;
    }
  }
}