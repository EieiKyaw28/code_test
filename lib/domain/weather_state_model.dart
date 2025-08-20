import 'dart:io';

import 'package:flutter/widgets.dart';

class WeatherStateModel {
  final TextEditingController? cityController;
  final bool? unitToggle;

  const WeatherStateModel({
    this.cityController,
    this.unitToggle,
  });

  // CopyWith
  WeatherStateModel copyWith({
    String? id,
    TextEditingController? cityController,
    bool? unitToggle,
  }) {
    return WeatherStateModel(
      cityController: cityController ?? this.cityController,
      unitToggle: unitToggle ?? this.unitToggle,
    );
  }

  static WeatherStateModel initial = WeatherStateModel(
    cityController: TextEditingController(),
    unitToggle: null,
  );

  // From JSON
  factory WeatherStateModel.fromJson(Map<String, dynamic> json) {
    return WeatherStateModel(
      cityController: json['cityController'] ?? '',
      unitToggle: json['unitToggle'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'cityController': cityController,
      'unitToggle': unitToggle,
    };
  }
}
