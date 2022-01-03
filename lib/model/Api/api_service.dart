import 'package:http/http.dart' as http;
import 'package:restaurantsapp/model/restaurant_data.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<DataTempat> topHeadlines() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return dataTempatFromJson(response.body);
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
