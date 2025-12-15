import 'package:cours1/src/utiles/my_assets/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:cours1/src/ui/widgets/forms/text_input/text_input.dart';
import 'package:cours1/src/ui/widgets/forms/app_button/app_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(ImagesAssets.logo, width: 120, height: 120),
              const SizedBox(height: 30),
              TextInput(
                labelText: 'email',
                iconData: Icons.email,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(height: 10),
              TextInput(
                labelText: 'password',
                ispassword: true,
                iconData: Icons.lock,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(height: 10),
              AppButton(onPressed: () {}, text: 'Se connecter'),
            ],
          ),
        ),
      ),
    );
  }
}
