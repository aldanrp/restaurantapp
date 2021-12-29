import 'dart:convert';

import 'package:restaurantsapp/model/restaurant_data.dart';

Searchtempat searchtempatFromJson(String str) =>
    Searchtempat.fromJson(json.decode(str));

String searchtempatToJson(Searchtempat data) => json.encode(data.toJson());

class Searchtempat {
  Searchtempat({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory Searchtempat.fromJson(Map<String, dynamic> json) => Searchtempat(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
