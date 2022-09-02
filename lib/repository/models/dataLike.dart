// To parse this JSON data, do
//
//     final dataLike = dataLikeFromJson(jsonString);

import 'dart:convert';

DataLike dataLikeFromJson(String str) => DataLike.fromJson(json.decode(str));

String dataLikeToJson(DataLike data) => json.encode(data.toJson());

class DataLike {
  DataLike({
    required this.data,
  });

  List<Datum> data;

  factory DataLike.fromJson(Map<String, dynamic> json) => DataLike(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.like,
  });

  int id;
  bool like;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "like": like,
      };
}
