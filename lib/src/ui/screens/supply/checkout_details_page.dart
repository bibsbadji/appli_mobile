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
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
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
                  'Checkout Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // === Champs du formulaire ===
                // Exemple pour tous les champs
                TextInput(
                  controller: countryCtrl,
                  labelText: 'Country',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  borderColor: Colors.blue, // <- couleur personnalisée
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: firstNameCtrl,
                  labelText: 'First name',
                  validator: _required,
                  borderColor: Colors.blue, // <- ici aussi
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: lastNameCtrl,
                  labelText: 'Last name',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: addressCtrl,
                  labelText: 'Address',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: cityCtrl,
                  labelText: 'City',
                  validator: _required,
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  labelText: 'Postal code',
                  borderColor: Colors.blue,
                ),
                const SizedBox(height: 12),
                TextInput(
                  controller: phoneCtrl,
                  labelText: 'Phone',

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
                      child: Text('Save this information for next time'),
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
                        label: const Text('Return to Cart', style: TextStyle(color: Colors.blue)),
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
                        label: const Text('Continue to Payment', style: TextStyle(color: Colors.white)),
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
      return 'This field is required';
    }
    return null;
  }

  // ================= STEPPER =================
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
            Text('Shopping Cart', style: TextStyle(fontSize: 12)),
            Text('Checkout Details', style: TextStyle(fontSize: 12)),
            Text('Payment', style: TextStyle(fontSize: 12)),
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
    return Expanded(
      child: Container(height: 2, color: Colors.grey.shade300),
    );
  }
}
