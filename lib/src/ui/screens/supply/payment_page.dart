import 'package:flutter/material.dart';
import '../supply/supply.dart';

enum PaymentMethod { cash, card, mobile }

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod? selectedMethod;

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

  int get subtotal =>
      CartData.items.fold(0, (s, i) => s + i.product.price * i.quantity);

  int get total => subtotal - (subtotal * discount ~/ 100);

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Paiement',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: primary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepper(primary),
              const SizedBox(height: 20),

              const Text(
                ' Méthode de paiement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _paymentMethod(
                primary,
                icon: Icons.money,
                title: 'Cash',
                subtitle: 'Paiement à la livraison',
                value: PaymentMethod.cash,
              ),
              _paymentMethod(
                primary,
                icon: Icons.credit_card,
                title: 'Carte bancaire',
                subtitle: 'Visa, Mastercard',
                value: PaymentMethod.card,
              ),
              _paymentMethod(
                primary,
                icon: Icons.phone_android,
                title: 'Mobile Money',
                subtitle: 'Wave, Orange Money',
                value: PaymentMethod.mobile,
              ),

              if (selectedMethod == PaymentMethod.mobile)
                _input(_phoneCtrl, 'Numéro de téléphone', Icons.phone),

              if (selectedMethod == PaymentMethod.card) _cardForm(primary),

              const SizedBox(height: 24),
              _summary(primary),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                      label: const Text('Retour ', style: TextStyle(color: Colors.blue)),
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
                      onPressed:
                      selectedMethod == null ? null : _validateAndPay,
                      icon: const Icon(Icons.check, color: Colors.white,),
                      label: const Text('Payer', style: TextStyle(color: Colors.white),),
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
    );
  }

  // ================= STEPPER =================
  Widget _stepper(Color primary) {
    return Column(
      children: [
        Row(
          children: [
            _circle(primary, done: true),
            _line(),
            _circle(primary, done: true),
            _line(),
            _circle(primary, active: true),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cart', style: TextStyle(fontSize: 12)),
            Text('Details', style: TextStyle(fontSize: 12)),
            Text('Payment', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _circle(Color primary, {bool active = false, bool done = false}) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: active || done ? primary : Colors.grey.shade300,
      child: done
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : active
          ? const CircleAvatar(radius: 4, backgroundColor: Colors.white)
          : null,
    );
  }

  Widget _line() =>
      Expanded(child: Container(height: 2, color: Colors.grey.shade300));

  // ================= PAYMENT METHOD =================
  Widget _paymentMethod(
      Color primary, {
        required IconData icon,
        required String title,
        required String subtitle,
        required PaymentMethod value,
      }) {
    final selected = selectedMethod == value;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? primary : Colors.transparent),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Icon(icon, color: primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: primary,
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD FORM =================
  Widget _cardForm(Color primary) {
    return Column(
      children: [
        _input(_cardNameCtrl, 'Nom sur la carte', Icons.person),
        const SizedBox(height: 12),
        _input(_cardNumberCtrl, 'Numéro de carte', Icons.credit_card),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input(_expiryCtrl, 'MM/AA', Icons.date_range)),
            const SizedBox(width: 12),
            Expanded(child: _input(_cvvCtrl, 'CVV', Icons.lock)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input(_discountCtrl, 'Code promo', Icons.discount)),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _applyDiscount,
              style: ElevatedButton.styleFrom(backgroundColor: primary),
              child: const Text('Apply'),
            ),
          ],
        ),
      ],
    );
  }

  // ================= INPUT =================
  Widget _input(
      TextEditingController ctrl, String label, IconData icon) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ================= SUMMARY =================
  Widget _summary(Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _row('Produits', CartData.items.length.toString()),
          _row('Sous-total', '$subtotal FCFA'),
          if (discount > 0) _row('Réduction', '-$discount%'),
          const Divider(),
          _row('Total', '$total FCFA', bold: true),
        ],
      ),
    );
  }

  Widget _row(String l, String v, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l),
        Text(v,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
      ],
    );
  }

  // ================= ACTIONS =================
  void _applyDiscount() {
    if (_discountCtrl.text.trim().toUpperCase() == 'PROMO10') {
      setState(() => discount = 10);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Réduction -10% appliquée')),
      );
    }
  }

  void _validateAndPay() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Paiement réussi'),
        content: Text('Total payé : $total FCFA'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
