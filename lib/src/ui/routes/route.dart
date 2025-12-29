import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:cours1/src/ui/screens/home/home.dart';
import 'package:cours1/src/ui/screens/login/login.dart';
import 'package:cours1/src/ui/screens/splash_screen.dart';
import 'package:cours1/src/ui/screens/supply/checkout_details_page.dart';
import 'package:cours1/src/ui/screens/supply/payment_page.dart';
import 'package:cours1/src/ui/screens/supply/supply.dart';
import 'package:flutter/material.dart';

import '../screens/supply/cart_page.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case home:
        return MaterialPageRoute(
          builder: (_) => const Home(userName: '', userEmail: ''),
        );
      case supply:
        return MaterialPageRoute(builder: (_) => const Supply());
      case basket: // ici on gère la route panier
        return MaterialPageRoute(builder: (_) => const CartPage());
        case checkout:
          return MaterialPageRoute(builder: (_) => CheckoutDetailsPage());
      case payment:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
