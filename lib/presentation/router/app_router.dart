import 'package:flutter/material.dart';
import 'package:weather/presentation/screens/HomePage.dart';
import 'package:weather/presentation/screens/LocationsPage.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (context) => LocationsPage());
      case '/show':
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return null;
    }
  }
}