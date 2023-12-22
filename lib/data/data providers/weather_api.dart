import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/data/models/weather_model.dart';

class WeatherApi{
  Future<http.Response> getWeather(String city) async{
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));
    if (response.statusCode == 200){
      return response;
    }
    throw Exception();
  }
}