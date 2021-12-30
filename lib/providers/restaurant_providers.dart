import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';
import 'package:restaurantsapp/model/searchplace_data.dart';

class RestaurantData with ChangeNotifier {
  List<Restaurant> tempat = [];
  late Restaurants detailsresturant;
  List<Restaurant> search = [];
  late bool _error;

  String urlmaster = "https://restaurant-api.dicoding.dev";

  Future<void> getRestaurant() async {
    Uri url = Uri.parse('$urlmaster/list');
    try {
      var hasilgetdata = await http.get(url);

      final DataTempat data = dataTempatFromJson(hasilgetdata.body);
      _error = data.error;
      if (_error == true) {
        throw data.message;
      } else {
        tempat = data.restaurants;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getSearchRestaurant(String query) async {
    Uri url = Uri.parse('$urlmaster/search?q=$query');

    try {
      var hasilgetdata = await http.get(url);
      final Searchtempat data = searchtempatFromJson(hasilgetdata.body);
      _error = data.error;
      if (_error == true) {
        throw _error;
      } else {
        search = data.restaurants;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getRestaurantid(String id) async {
    Uri url = Uri.parse('$urlmaster/detail/$id');

    try {
      var hasilgetdata = await http.get(url);
      final Datatempat data = datatempatFromJson(hasilgetdata.body);
      _error = data.error;
      if (_error == true) {
        throw data.message;
      } else {
        detailsresturant = data.restaurant;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }
}
