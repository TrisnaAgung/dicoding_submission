// To parse this JSON data, do
//
//     final dataUniversitas = dataUniversitasFromJson(jsonString);

import 'dart:convert';

DataUniversitas dataUniversitasFromJson(String str) =>
    DataUniversitas.fromJson(json.decode(str));

String dataUniversitasToJson(DataUniversitas data) =>
    json.encode(data.toJson());

class DataUniversitas {
  DataUniversitas({
    required this.data,
  });

  List<DataUniv> data;

  factory DataUniversitas.fromJson(Map<String, dynamic> json) =>
      DataUniversitas(
        data:
            List<DataUniv>.from(json["data"].map((x) => DataUniv.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataUniv {
  DataUniv({
    required this.id,
    required this.path,
    required this.title,
    required this.content,
  });

  int id;
  String path;
  String title;
  String content;

  factory DataUniv.fromJson(Map<String, dynamic> json) => DataUniv(
        id: json["id"],
        path: json["path"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "title": title,
        "content": content,
      };
}
