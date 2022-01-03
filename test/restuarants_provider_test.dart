import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';
import 'package:restaurantsapp/providers/restaurant_providers.dart';

const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "city": "Medan",
  "address": "Jln. Pandeglang no 19",
  "pictureId": "14",
  "rating": 4.2,
};

const detailRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "city": "Medan",
  "address": "Jln. Pandeglang no 19",
  "pictureId": "14",
  "rating": 4.2,
  "categories": [
    {"name": "Italia"},
    {"name": "Modern"}
  ],
  "menus": {
    "foods": [
      {"name": "Paket rosemary"},
      {"name": "Toastie salmon"},
      {"name": "Bebek crepes"},
      {"name": "Salad lengkeng"}
    ],
    "drinks": [
      {"name": "Es krim"},
      {"name": "Sirup"},
      {"name": "Jus apel"},
      {"name": "Jus jeruk"},
      {"name": "Coklat panas"},
      {"name": "Air"},
      {"name": "Es kopi"},
      {"name": "Jus alpukat"},
      {"name": "Jus mangga"},
      {"name": "Teh manis"},
      {"name": "Kopi espresso"},
      {"name": "Minuman soda"},
      {"name": "Jus tomat"}
    ]
  },
  "customerReviews": [
    {
      "name": "Ahmad",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    }
  ]
};

void main() {
  group('Restaurant Provider Test', () {
    late RestaurantData restaurant;

    setUp(() {
      restaurant = RestaurantData();
    });

    test('verify that get data all restaurants json parse run expected',
        () async {
      await restaurant.getRestaurant();
      var result = restaurant.tempat[0];
      var jsonRestaurant = Restaurant.fromJson(testRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });

    test('verify restaurant search by name restaurant run expected', () async {
      String query = 'Melting Pot';
      await restaurant.getSearchRestaurant(query);
      var result = restaurant.search[0];
      var jsonRestaurant = Restaurant.fromJson(testRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });

    test('verify restaurant detail by id restaurant run expected', () async {
      String query = 'rqdv5juczeskfw1e867';
      await restaurant.getRestaurantid(query);
      var result = restaurant.detailsresturant;
      var jsonRestaurant = Restaurants.fromJson(detailRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
      expect(result.address == jsonRestaurant.address, true);
      expect(
          result.categories.length == jsonRestaurant.categories.length, true);
      expect(
          result.menus.foods.length == jsonRestaurant.menus.foods.length, true);
    });
  });
}
