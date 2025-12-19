import 'package:cours1/src/ui/screens/home/home.dart';
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
      title: 'Appli_mobile',
      debugShowCheckedModeBanner: false, // Enlever le bandeau "Debug"
      
      // Thème de l'application
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[700],
        fontFamily: 'Roboto',
        
        // Style des boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        // Style de l'AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Style des champs de texte
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
      
      // Page de démarrage
      initialRoute: '/',
      
      // Routes nommées
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        // La route /home est gérée différemment car elle a besoin de paramètres
      },
      
      // Gestion des routes qui nécessitent des paramètres
      onGenerateRoute: (settings) {
        // Route pour Home avec paramètres
        if (settings.name == '/home') {
          final args = settings.arguments as Map<String, String>?;
          
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => Home(
                userName: args['userName'] ?? 'Utilisateur',
                userEmail: args['userEmail'] ?? '',
              ),
            );
          }
        }
        
        // Si aucune route ne correspond
        return null;
      },
      
      // Page 404 (optionnel)
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Erreur')),
            body: const Center(
              child: Text('Page non trouvée'),
            ),
          ),
        );
      },
    );
  }
}