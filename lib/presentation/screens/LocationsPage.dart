import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/buisness%20logic/bloc/weather_bloc.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    TextEditingController cityTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: cityTextController,
                decoration: InputDecoration(
                  hintText: "Search for the location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    weatherBloc.add(FetchWeatherEvent(city: cityTextController.text));
                    Navigator.of(context).pushNamed('/show');
                  },
                  child: Text('Search the location')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
