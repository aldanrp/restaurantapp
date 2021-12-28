// To parse this JSON data, do
//
//     final dataTempat = dataTempatFromJson(jsonString);

import 'dart:convert';

Datatempat datatempatFromJson(String str) =>
    Datatempat.fromJson(json.decode(str));

String datatempatToJson(Datatempat data) => json.encode(data.toJson());

class Datatempat {
  Datatempat({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurants restaurant;

  factory Datatempat.fromJson(Map<String, dynamic> json) => Datatempat(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurants.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class Restaurants {
  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
