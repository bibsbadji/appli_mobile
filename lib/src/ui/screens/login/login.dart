import 'package:cours1/src/ui/screens/home/home.dart';
import 'package:cours1/src/utiles/my_assets/images_assets.dart';
// Importez la page d'accueil
import 'package:flutter/material.dart';
import 'package:cours1/src/ui/widgets/forms/text_input/text_input.dart';
import 'package:cours1/src/ui/widgets/forms/app_button/app_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Contrôleurs pour récupérer les valeurs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction de connexion
  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // TODO: Vérifier les identifiants (API, Firebase, etc.)
      
      // Si connexion réussie, naviguer vers HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );

      // Message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bienvenue $email!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                
                // Logo
                Image.asset(
                  ImagesAssets.logo,
                  width: 120,
                  height: 120,
                ),
                
                const SizedBox(height: 30),
                
                // Champ Email
                TextInput(
                  labelText: 'Email',
                  iconData: Icons.email,
                  controller: _emailController,
                  borderRadius: BorderRadius.circular(14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    if (!value.contains('@')) {
                      return 'Email invalide';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 10),
                
                // Champ Mot de passe
                TextInput(
                  labelText: 'Mot de passe',
                  ispassword: true,
                  iconData: Icons.lock,
                  controller: _passwordController,
                  borderRadius: BorderRadius.circular(14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 10),
                
                // Lien "Mot de passe oublié"
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Page mot de passe oublié
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fonctionnalité à venir'),
                        ),
                      );
                    },
                    child: const Text('Mot de passe oublié ?'),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Bouton de connexion
                AppButton(
                  onPressed: _login,
                  text: 'Se connecter',
                ),
                
                const SizedBox(height: 20),
                
                // Lien vers inscription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'avez pas de compte ? "),
                    TextButton(
                      onPressed: () {
                        // TODO: Navigation vers page d'inscription
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Page d\'inscription à venir'),
                          ),
                        );
                      },
                      child: const Text('Inscrivez-vous'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}