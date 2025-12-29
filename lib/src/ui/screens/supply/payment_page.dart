import 'package:flutter/material.dart';
import '../supply/supply.dart'; // CartData, CartItem, Product

enum PaymentMethod { cash, card, mobile }

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod? selectedMethod;

  final _cardFormKey = GlobalKey<FormState>();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  @override
  void dispose() {
    _cardNumberCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Méthode de paiement',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _paymentMethod(
              icon: Icons.money,
              title: 'Cash',
              subtitle: 'Paiement à la livraison',
              value: PaymentMethod.cash,
            ),
            _paymentMethod(
              icon: Icons.credit_card,
              title: 'Carte bancaire',
              subtitle: 'Visa, Mastercard',
              value: PaymentMethod.card,
            ),
            _paymentMethod(
              icon: Icons.phone_android,
              title: 'Mobile Money',
              subtitle: 'Wave, Orange Money',
              value: PaymentMethod.mobile,
            ),

            const SizedBox(height: 16),

            // Formulaire carte bancaire
            if (selectedMethod == PaymentMethod.card)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Form(
                  key: _cardFormKey,
                  child: Column(
                    children: [
                      _textField(
                        _cardNumberCtrl,
                        'Numéro de carte',
                        TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _textField(
                              _expiryCtrl,
                              'MM/AA',
                              TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _textField(
                              _cvvCtrl,
                              'CVV',
                              TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            _summaryCard(), // résumé de commande

            const Spacer(),

            // Boutons Retour + Checkout
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    label: const Text('Return to Cart'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _validateAndPay,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= GET TOTAL =================
  int get total {
    return CartData.items.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  // ================= APPBAR =================
  AppBar _appBar() => AppBar(
    title: const Text(
      'Checkout',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(height: 1, color: Colors.grey[300]),
    ),
  );

  // ================= SUMMARY CARD =================
  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _SummaryRow('Produits', CartData.items.length.toString()),
          const SizedBox(height: 8),
          _SummaryRow(
            'Sous-total',
            '${CartData.items.fold(0, (sum, item) => sum + item.product.price * item.quantity)} FCFA',
          ),
          const SizedBox(height: 8),
          const Divider(),
          _SummaryRow('Total', '$total FCFA', bold: true),
        ],
      ),
    );
  }

  // ================= PAYMENT METHOD =================
  Widget _paymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required PaymentMethod value,
  }) {
    final isSelected = selectedMethod == value;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // ================= VALIDATION & PAIEMENT =================
  void _validateAndPay() {
    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une méthode de paiement'),
        ),
      );
      return;
    }

    if (selectedMethod == PaymentMethod.card) {
      if (!_cardFormKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Veuillez remplir correctement les informations de votre carte',
            ),
          ),
        );
        return;
      }
    }

    // Paiement validé
    debugPrint('Paiement validé ! Total: $total FCFA');
    debugPrint('Méthode: $selectedMethod');
    if (selectedMethod == PaymentMethod.card) {
      debugPrint('Numéro: ${_cardNumberCtrl.text}');
      debugPrint('Expiration: ${_expiryCtrl.text}');
      debugPrint('CVV: ${_cvvCtrl.text}');
    }

    // Confirmation
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Paiement effectué'),
        content: Text('Total payé: $total FCFA\nMéthode: $selectedMethod'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ================= TEXT FIELD HELPER =================
  Widget _textField(
    TextEditingController ctrl,
    String label,
    TextInputType type,
  ) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Champ requis';
        return null;
      },
    );
  }
}

// ================= SUMMARY ROW =================
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
        ),
      ],
    );
  }
}
