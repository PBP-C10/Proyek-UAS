// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
  String reviewText;
  int rating;

  String? selectedBookTitle;

  Fields({
    required this.reviewText,
    required this.rating,
    required this.selectedBookTitle,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        reviewText: json["review_text"],
        rating: json["rating"],
        selectedBookTitle: json["selected_book_title"],
      );

  Map<String, dynamic> toJson() => {
        "review_text": reviewText,
        "rating": rating,
        "selected_book_title": selectedBookTitle,
      };
}
