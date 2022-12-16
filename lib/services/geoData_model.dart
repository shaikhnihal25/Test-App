// To parse this JSON data, do
//
//     final geoData = geoDataFromJson(jsonString);

import 'dart:convert';

List<GeoData> geoDataFromJson(String str) =>
    List<GeoData>.from(json.decode(str).map((x) => GeoData.fromJson(x)));

String geoDataToJson(List<GeoData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeoData {
  GeoData({
    this.geojson,
  });

  String geojson;

  factory GeoData.fromJson(Map<String, dynamic> json) => GeoData(
        geojson: json["geojson"] == null ? null : json["geojson"],
      );

  Map<String, dynamic> toJson() => {
        "geojson": geojson == null ? null : geojson,
      };
}
