import 'package:equatable/equatable.dart';

class CommonQueryModel extends Equatable {
  const CommonQueryModel({this.city, this.lat, this.lon, this.day});

  final String? city;
  final double? lat;
  final double? lon;
  final String? day;

  @override
  List<Object?> get props => [city, lat, lon, day];

  @override
  bool get stringify => false;
}
