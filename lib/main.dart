import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/buisness%20logic/bloc/weather_bloc.dart';
import 'package:weather/data/data%20providers/weather_api.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repository/weather_repository.dart';
import 'package:weather/presentation/router/app_router.dart';

import 'presentation/screens/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBloc.storage.clear();
  runApp(MyApp(
    weatherApi: WeatherApi(),
    weatherRepository: WeatherRepository(weatherApi: WeatherApi()),
  ));
}


class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final WeatherApi weatherApi;
  MyApp({super.key ,required this.weatherRepository, required this.weatherApi});

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(weatherRepository: weatherRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}