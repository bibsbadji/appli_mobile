import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';
import '../../widgets/forms/text_input/text_input.dart';

class CheckoutDetailsPage extends StatefulWidget {
  const CheckoutDetailsPage({super.key});

  @override
  State<CheckoutDetailsPage> createState() => _CheckoutDetailsPageState();
}

class _CheckoutDetailsPageState extends State<CheckoutDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final countryCtrl = TextEditingController(text: 'UAE');
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool saveInfo = false;

  @override
  void dispose() {
    countryCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    addressCtrl.dispose();
    cityCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Détails', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(),
                const SizedBox(height: 20),
                const Text(
                  ' Informations de livraison',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // === Champs du formulaire ===
                // Exemple pour tous les champs
                TextInput(
                  controller: countryCtrl,
                  labelText: 'Pays/Région',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  borderColor: Colors.blue, // <- couleur personnalisée
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: firstNameCtrl,
                  labelText: 'Prénom',
                  validator: _required,
                  borderColor: Colors.blue, // <- ici aussi
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: lastNameCtrl,
                  labelText: 'Nom',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: addressCtrl,
                  labelText: 'Adresse',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: cityCtrl,
                  labelText: 'Ville',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  labelText: 'Code postal',
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: phoneCtrl,
                  labelText: 'Numero de téléphone',

                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 20),



                // === Checkbox sauvegarde info ===
                Row(
                  children: [
                    Checkbox(
                      value: saveInfo,
                      activeColor: Colors.blue,
                      onChanged: (v) => setState(() => saveInfo = v ?? false),
                    ),
                    const Expanded(
                      child: Text('Enregistrer ces informations pour la prochaine fois'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // === Boutons navigation ===
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.blue),
                        label: const Text('Retour au panier', style: TextStyle(color: Colors.blue)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, payment);
                          }
                        },
                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                        label: const Text('Continuer au paiement', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
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

  // ================= HELPERS =================
  static String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ce champ est requis';
    }
    return null;
  }


  Widget _stepper() {
    return Column(
      children: [
        Row(
          children: [
            _circle(done: true),
            _line(),
            _circle(active: true),
            _line(),
            _circle(),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Panier', style: TextStyle(fontSize: 12)),
            Text(' Details', style: TextStyle(fontSize: 12)),
            Text('Paiement', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _circle({bool active = false, bool done = false}) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: active || done ? Colors.blue : Colors.grey.shade300,
      child: done
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : active
          ? const CircleAvatar(radius: 4, backgroundColor: Colors.white)
          : null,
    );
  }

  Widget _line() {
    return Expanded(child: Container(height: 2, color: Colors.grey.shade300));
  }
}
