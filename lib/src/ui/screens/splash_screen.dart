import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:cours1/src/utiles/my_assets/images_assets.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation du logo (scale)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward(); // démarre l'animation

    // Redirection après 2 secondes
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // même couleur que le login
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Logo dans un cercle avec animation
            ScaleTransition(
              scale: _animation,
              child: CircleAvatar(
                radius: 50, // taille du logo
                backgroundColor: Colors.white.withOpacity(0.1), // fond léger
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImagesAssets.logo,
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Texte de chargement
            const Text(
              "Loading...",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 15),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
