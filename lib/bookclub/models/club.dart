// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

List<Club> clubFromJson(String str) =>
    List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  String model;
  int pk;
  Fields fields;

  Club({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
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
  int owner;
  String name;
  String description;
  List<int> members;
  List<int> recommendedBooks;
  bool isOwner;
  bool isMember;

  Fields({
    required this.owner,
    required this.name,
    required this.description,
    required this.members,
    required this.recommendedBooks,
    required this.isOwner,
    required this.isMember,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        owner: json["owner"],
        name: json["name"],
        description: json["description"],
        members: List<int>.from(json["members"].map((x) => x)),
        recommendedBooks:
            List<int>.from(json["recommended_books"].map((x) => x)),
        isOwner: json["is_owner"],
        isMember: json["is_member"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "name": name,
        "description": description,
        "members": List<dynamic>.from(members.map((x) => x)),
        "recommended_books": List<dynamic>.from(recommendedBooks.map((x) => x)),
        "is_owner": isOwner,
        "is_member": isMember,
      };
}
