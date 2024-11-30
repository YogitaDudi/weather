import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';
import 'package:weather/screen/constins_screen.dart';


class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<WeatherModel> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      throw Exception("Failed to load weather data");
    }
  }
}



