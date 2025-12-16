import 'package:cours1/src/ui/screens/cart_page.dart';
import 'package:cours1/src/ui/screens/supply.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Supply(),
      routes: {
        '/cart_page': (context) => const CartPage(), // ici on définit la route
      },
    );
  }
}
