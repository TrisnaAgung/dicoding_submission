// To parse this JSON data, do
//
//     final dataFavorite = dataFavoriteFromJson(jsonString);

import 'dart:convert';

DataFavorite dataFavoriteFromJson(String str) =>
    DataFavorite.fromJson(json.decode(str));

String dataFavoriteToJson(DataFavorite data) => json.encode(data.toJson());

class DataFavorite {
  DataFavorite({
    required this.data,
  });

  List<Datum> data;

  factory DataFavorite.fromJson(Map<String, dynamic> json) => DataFavorite(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.favorite,
  });

  int id;
  bool favorite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "favorite": favorite,
      };
}
