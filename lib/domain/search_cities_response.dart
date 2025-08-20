import 'dart:convert';

List<CityData> cityDataFromJson(String str) => List<CityData>.from(json.decode(str).map((x) => CityData.fromJson(x)));

class CityData {
    final int? id;
    final String? name;
    final String? region;
    final String? country;
    final double? lat;
    final double? lon;
    final String? url;

    CityData({
        this.id,
        this.name,
        this.region,
        this.country,
        this.lat,
        this.lon,
        this.url,
    });

    factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "url": url,
    };
}
