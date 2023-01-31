import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
      default:
        return null;
    }
  }
}
