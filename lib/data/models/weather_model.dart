import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherModel{
  final dynamic temperature;
  final dynamic humidity;
  final dynamic pressure;

  double get getTemperature => temperature - 273;

  WeatherModel({required this.temperature, required this.humidity, required this.pressure});

  factory WeatherModel.fromResponseToModel(http.Response response){
    final jsonDecoded = json.decode(response.body);
    final jsonWeather = jsonDecoded["main"];
    return WeatherModel(temperature: jsonWeather["temp"], humidity: jsonWeather["humidity"], pressure: jsonWeather["pressure"]);
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map){
    return WeatherModel(temperature: map["temperature"], humidity: map["humidity"], pressure: map["pressure"]);
  }
  }