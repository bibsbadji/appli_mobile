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

  // Controllers
  final _cardFormKey = GlobalKey<FormState>();
  final _cardNameCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  final _discountCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  int discount = 0;

  @override
  void dispose() {
    _cardNameCtrl.dispose();
    _cardNumberCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    _discountCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  // ================= TOTAL =================
  int get subtotal {
    return CartData.items.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  int get total => subtotal - (subtotal * discount ~/ 100);

  String get paymentLabel {
    switch (selectedMethod) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Carte bancaire';
      case PaymentMethod.mobile:
        return 'Mobile Money';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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

              if (selectedMethod == PaymentMethod.mobile)
                _textField(
                  _phoneCtrl,
                  'Numéro de téléphone (77, 78, 70, 76...)',
                  TextInputType.phone,
                ),
              const SizedBox(height: 16),
              if (selectedMethod == PaymentMethod.card) _cardForm(),

              const SizedBox(height: 24),
              _summaryCard(),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Return to Cart'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: selectedMethod == null
                          ? null
                          : _validateAndPay,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text(
                        'Checkout',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
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

  // ================= CARD FORM =================
  Widget _cardForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: _cardFormKey,
        child: Column(
          children: [
            _textField(_cardNameCtrl, 'Nom sur la carte', TextInputType.text),
            const SizedBox(height: 12),

            _textField(
              _cardNumberCtrl,
              'Numéro de carte',
              TextInputType.number,
              minLength: 16,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _textField(
                    _expiryCtrl,
                    'MM/AA',
                    TextInputType.datetime,
                    minLength: 4,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _textField(
                    _cvvCtrl,
                    'CVV',
                    TextInputType.number,
                    minLength: 3,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _textField(
                    _discountCtrl,
                    'Discount Code',
                    TextInputType.text,
                    minLength: 3,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _applyDiscount,
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= SUMMARY =================
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
          _SummaryRow('Sous-total', '$subtotal FCFA'),
          if (discount > 0) _SummaryRow('Réduction', '-$discount%'),
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

  // ================= VALIDATION =================
  void _validateAndPay() {
    if (selectedMethod == PaymentMethod.card &&
        !_cardFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Carte invalide')));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Paiement réussi'),
        content: Text('Total payé: $total FCFA\nMéthode: $paymentLabel'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ================= DISCOUNT =================
  void _applyDiscount() {
    if (_discountCtrl.text.trim().toUpperCase() == 'PROMO10') {
      setState(() => discount = 10);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎉 Réduction -10% appliquée')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Code promo invalide')));
    }
  }

  // ================= TEXT FIELD =================
  Widget _textField(
    TextEditingController ctrl,
    String label,
    TextInputType type, {
    int minLength = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Champ requis';
        if (v.length < minLength) return 'Format invalide';
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
