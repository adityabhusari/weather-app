import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/buisness%20logic/bloc/weather_bloc.dart';
import 'package:weather/data/models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<WeatherBloc,WeatherStates>(
              builder: (context, state) {
                if (state is WeatherIsNotSearched) {
                  return Text("Please Search for the Weather by clicking back!");
                }
                if (state is WeatherIsLoading){
                  return Center(child: CircularProgressIndicator());
                }
                if (state is WeatherIsLoaded){
                  return ShowWeather(weatherModel: state.weatherModel);
                }
                return Text("Error");
              },
            )
          ],
        ),
      ),
    );
  }
}

class ShowWeather extends StatelessWidget {
  final WeatherModel weatherModel;
  // final String city;
  
  const ShowWeather({Key? key, required this.weatherModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Temperature: ${weatherModel.getTemperature} Celsius"),
        Text("Humidity:${weatherModel.humidity}%"),
        Text("Pressure:${weatherModel.pressure} mb")
      ],
    ));
  }
}

