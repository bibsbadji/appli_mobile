import 'package:cours1/src/ui/routes/route.dart';
import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:cours1/src/ui/screens/login/login.dart';
import 'package:cours1/src/ui/screens/splash_screen.dart';
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
      onGenerateRoute: Routers.generateRoute,
      initialRoute: splash,
  
    );
  }
}
