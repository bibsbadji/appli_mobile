import 'package:cours1/src/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cours1/src/utiles/my_assets/images_assets.dart';

import 'package:cours1/src/ui/widgets/forms/text_input/text_input.dart';
import 'package:cours1/src/ui/widgets/forms/app_button/app_button.dart';
import 'package:cours1/src/data/users_data.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Contrôleurs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Variable pour afficher le chargement
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction de connexion
  void _login() {
    // Valider le formulaire
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Afficher le chargement
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Vérifier les identifiants
    User? user = UsersData.verifierConnexion(email, password);

    // Simuler un délai (comme si on contactait un serveur)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        // ✅ Connexion réussie
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bienvenue ${user.nom}!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Naviguer vers la page d'accueil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              userName: user.nom,
              userEmail: user.email,
            ),
          ),
        );
      } else {
        // ❌ Identifiants incorrects
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou mot de passe incorrect'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );

        // Effacer le mot de passe
        _passwordController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Connexion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:

      Padding(
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

                const Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                // Champ Email
                TextInput(
                  labelText: 'Email',
                  iconData: Icons.email,
                  controller: _emailController,
                  borderColor: Colors.blue,
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

                const SizedBox(height: 30),

                // Champ Mot de passe
                TextInput(
                  labelText: 'Mot de passe',
                  ispassword: true,
                  borderColor: Colors.blue,
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

                // Mot de passe oublié
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _showForgotPasswordDialog();
                    },
                    child: const Text('Mot de passe oublié ?', style: TextStyle(color: Colors.blue,),)
                  ),
                ),

                const SizedBox(height: 20),

                // Bouton de connexion
                _isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
                    : AppButton(
                  onPressed: _login,
                  bgColor: Colors.blue,
                  text: 'Se connecter',
                ),

                const SizedBox(height: 20),

                // Lien vers inscription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Pas encore de compte ? ", style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: () {
                        _showRegisterDialog();
                      },
                      child: const Text('Inscrivez-vous', style: TextStyle(color: Colors.blue,)),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Afficher les comptes de test

              ],
            ),
          ),
        ),
      ),
    );
  }


  // Dialog mot de passe oublié
  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mot de passe oublié'),
        content: const Text(
          'Pour cette démo, consultez la liste des comptes de test ci-dessous.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Dialog inscription
  void _showRegisterDialog() {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inscription'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              String email = emailController.text.trim();
              String name = nameController.text.trim();
              String password = passwordController.text.trim();

              if (email.isEmpty || name.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Veuillez remplir tous les champs',style: TextStyle(
                        color: Colors.blue
                    ),),
                    backgroundColor: Colors.orange,


                  ),
                );
                return;
              }

              if (!email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email invalide'),
                    backgroundColor: Colors.red,
                  ),

                );
                return;
              }

              if (UsersData.emailExiste(email)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cet email est déjà utilisé'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Ajouter le nouvel utilisateur
              UsersData.ajouterUtilisateur(User(
                email: email,
                nom: name,
                motDePasse: password,
              ));

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Compte créé avec succès !'),
                  backgroundColor: Colors.green,
                ),
              );

              // Remplir automatiquement les champs
              _emailController.text = email;
              _passwordController.text = password;
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }
}