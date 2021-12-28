import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';

class RestaurantData with ChangeNotifier {
  List<Restaurant> tempat = [];
  late Restaurants detailsresturant;

  String urlmaster = "https://restaurant-api.dicoding.dev";

  Future<void> getRestaurant() async {
    Uri url = Uri.parse('$urlmaster/list');

    var hasilgetdata = await http.get(url);
    print(hasilgetdata.body);

    final DataTempat data = dataTempatFromJson(hasilgetdata.body);
    tempat = data.restaurants;

    notifyListeners();
  }

  Future<void> getRestaurantid(String id) async {
    Uri url = Uri.parse('$urlmaster/detail/$id');

    var hasilgetdata = await http.get(url);
    print(hasilgetdata.body);

    final Datatempat data = datatempatFromJson(hasilgetdata.body);
    detailsresturant = data.restaurant;

    notifyListeners();
  }
}
