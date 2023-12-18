// To parse this JSON data, do
//
//     final bubble = bubbleFromJson(jsonString);

import 'dart:convert';

List<Bubble> bubbleFromJson(String str) =>
    List<Bubble>.from(json.decode(str).map((x) => Bubble.fromJson(x)));

String bubbleToJson(List<Bubble> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bubble {
  String model;
  int pk;
  Fields fields;

  Bubble({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Bubble.fromJson(Map<String, dynamic> json) => Bubble(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String username;
  int club;
  String content;
  DateTime timestamp;

  Fields({
    required this.user,
    required this.username,
    required this.club,
    required this.content,
    required this.timestamp,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        club: json["club"],
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "club": club,
        "content": content,
        "timestamp": timestamp.toIso8601String(),
      };
}
