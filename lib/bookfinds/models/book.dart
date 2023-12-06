// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
  String isbn;
  String title;
  String subtitle;
  String author;
  Category category;
  String thumbnail;
  String description;
  int publishedYear;
  String averageRating;
  int numPages;
  int ratingsCount;
  int price;

  Fields({
    required this.isbn,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.category,
    required this.thumbnail,
    required this.description,
    required this.publishedYear,
    required this.averageRating,
    required this.numPages,
    required this.ratingsCount,
    required this.price,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        subtitle: json["subtitle"],
        author: json["author"],
        category: categoryValues.map[json["category"]]!,
        thumbnail: json["thumbnail"],
        description: json["description"],
        publishedYear: json["published_year"],
        averageRating: json["average_rating"],
        numPages: json["num_pages"],
        ratingsCount: json["ratings_count"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "subtitle": subtitle,
        "author": author,
        "category": categoryValues.reverse[category],
        "thumbnail": thumbnail,
        "description": description,
        "published_year": publishedYear,
        "average_rating": averageRating,
        "num_pages": numPages,
        "ratings_count": ratingsCount,
        "price": price,
      };
}

enum Category {
  ADVENTURE_STORIES,
  ART,
  CHILDREN_S_STORIES,
  COMICS_GRAPHIC_NOVELS,
  DETECTIVE_AND_MYSTERY_STORIES,
  DRAMA,
  FANTASY_FICTION,
  HISTORY,
  JUVENILE_FICTION,
  SCIENCE_FICTION
}

final categoryValues = EnumValues({
  "Adventure stories": Category.ADVENTURE_STORIES,
  "Art": Category.ART,
  "Children's stories": Category.CHILDREN_S_STORIES,
  "Comics & Graphic Novels": Category.COMICS_GRAPHIC_NOVELS,
  "Detective and mystery stories": Category.DETECTIVE_AND_MYSTERY_STORIES,
  "Drama": Category.DRAMA,
  "Fantasy fiction": Category.FANTASY_FICTION,
  "History": Category.HISTORY,
  "Juvenile Fiction": Category.JUVENILE_FICTION,
  "Science fiction": Category.SCIENCE_FICTION
});

enum Model { BOOKFINDS_BOOK }

final modelValues = EnumValues({"bookfinds.book": Model.BOOKFINDS_BOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
