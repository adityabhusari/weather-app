import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repository/weather_repository.dart';

abstract class WeatherEvents extends Equatable{}

class FetchWeatherEvent extends WeatherEvents{
  final String city;

  FetchWeatherEvent({required this.city});

  @override
  List<Object?> get props => [city];
}

abstract class WeatherStates extends Equatable{}

class WeatherIsLoading extends WeatherStates{
  @override
  List<Object?> get props => [];
}

class WeatherIsLoaded extends WeatherStates{
  WeatherModel weatherModel;

  WeatherIsLoaded({required this.weatherModel});

  Map<String, dynamic> toMap(){
    return {
      "temperature": weatherModel.getTemperature.toString(),
      "humidity": weatherModel.humidity.toString(),
      "pressure": weatherModel.pressure.toString()
    };
  }

  String toJsonFromMap() => json.encode(toMap());

  factory WeatherIsLoaded.fromMap(Map<String, dynamic> map){
    WeatherModel weatherModel = WeatherModel(temperature: map["temperature"], humidity: map["humidity"], pressure: map["pressure"]);
    return WeatherIsLoaded(weatherModel: weatherModel);
  }

  factory WeatherIsLoaded.fromJson(String source){
    return WeatherIsLoaded.fromMap(json.decode(source));
  }
  @override
  List<Object?> get props => [weatherModel];
}

class WeatherIsNotLoaded extends WeatherStates{
  @override
  List<Object?> get props => [];
}

class WeatherIsNotSearched extends WeatherStates{
  @override
  List<Object?> get props => [];
}

class WeatherBloc extends HydratedBloc<WeatherEvents,WeatherStates>{
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherIsNotSearched()){
    on<FetchWeatherEvent>((event, emit) async{
      emit(WeatherIsLoading());

      try{
        WeatherModel weatherModel = await weatherRepository.getWeatherDataModel(event.city);
        emit(WeatherIsLoaded(weatherModel: weatherModel));
      }
      catch (e){
        emit(WeatherIsNotLoaded());
        print(e.toString());
      }
    }
    );
  }

  @override
  void onChange(Change<WeatherStates> change) {
    print(change);
    super.onChange(change);
  }
  @override
  WeatherStates? fromJson(Map<String, dynamic> json) {
    try{
      print("RUN PLEASE");
      return WeatherIsLoaded.fromMap(json);
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherStates state) {
    if (state is WeatherIsLoaded){
      print("${state.weatherModel.getTemperature} ${state.weatherModel.humidity} ${state.weatherModel.pressure}");
      return state.toMap();
    }
  }
}