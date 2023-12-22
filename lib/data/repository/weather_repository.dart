import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/data/data%20providers/weather_api.dart';
import 'package:weather/data/models/weather_model.dart';

class WeatherRepository{

  final WeatherApi weatherApi;

  WeatherRepository({required this.weatherApi});

  Future<WeatherModel> getWeatherDataModel(String city) async{
    final http.Response rawData =  await weatherApi.getWeather(city);
    WeatherModel weatherModel = WeatherModel.fromResponseToModel(rawData);
    return weatherModel;
  }
}