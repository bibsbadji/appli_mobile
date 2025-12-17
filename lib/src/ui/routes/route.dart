import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:cours1/src/ui/screens/login/login.dart';
import 'package:cours1/src/ui/screens/supply/splash_screen.dart';
import 'package:flutter/material.dart';

import '../screens/supply/cart_page.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:  
            return MaterialPageRoute(builder: (_) => const Login());
      case basket: // ici on gère la route panier
        return MaterialPageRoute(builder: (_) => const CartPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}