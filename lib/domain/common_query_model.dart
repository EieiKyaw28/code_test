import 'package:equatable/equatable.dart';

class CommonQueryModel extends Equatable {
  const CommonQueryModel({this.city, this.lat, this.lon, this.day});

  final String? city;
  final double? lat;
  final double?lon;
  final String? day;

  CommonQueryModel copyWith({
    String? city,
    double? lat,
    double? lon,
    String? day,
  }) {
    return CommonQueryModel(
      city: city ?? this.city,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      day: day ?? this.day,
    );
  }

  @override
  List<Object?> get props => [city, lat, lon, day];

  @override
  bool get stringify => false;
}
