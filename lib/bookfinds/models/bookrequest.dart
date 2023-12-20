// To parse this JSON data, do
//
//     final bookRequest = bookRequestFromJson(jsonString);

import 'dart:convert';

List<BookRequest> bookRequestFromJson(String str) => List<BookRequest>.from(
    json.decode(str).map((x) => BookRequest.fromJson(x)));

String bookRequestToJson(List<BookRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookRequest {
  Model model;
  int pk;
  Fields fields;

  BookRequest({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BookRequest.fromJson(Map<String, dynamic> json) => BookRequest(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String title;
  String author;
  String category;
  Status status;

  Fields({
    required this.user,
    required this.title,
    required this.author,
    required this.category,
    required this.status,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        author: json["author"],
        category: json["category"],
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "category": category,
        "status": statusValues.reverse[status],
      };
}

enum Status { REQ }

final statusValues = EnumValues({"REQ": Status.REQ});

enum Model { BOOKFINDS_BOOKREQUEST }

final modelValues =
    EnumValues({"bookfinds.bookrequest": Model.BOOKFINDS_BOOKREQUEST});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
