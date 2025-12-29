import 'package:flutter/material.dart';
import 'package:cours1/src/ui/routes/route_path.dart';
import 'supply.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> get cartItems => CartData.items;

  int get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Panier', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: Colors.blue),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _stepper(),
            const SizedBox(height: 16),
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                  child: Text('Your cart is empty',
                      style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _cartItem(item);
                },
              ),

            ),
            const SizedBox(height: 16),
            _totalSection(),
            const SizedBox(height: 16),
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  // ================= STEPPER =================
  Widget _stepper() {
    return Column(
      children: [
        Row(
          children: [
            _stepCircle(active: true),
            _stepLine(),
            _stepCircle(),
            _stepLine(),
            _stepCircle(),
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

  Widget _stepCircle({bool active = false}) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: active ? Colors.blue : Colors.grey.shade300,
      child: active
          ? const CircleAvatar(radius: 4, backgroundColor: Colors.white)
          : null,
    );
  }

  Widget _stepLine() {
    return Expanded(
      child: Container(height: 2, color: Colors.grey.shade300),
    );
  }

  // ================= CART ITEM =================
  Widget _cartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(item.product.image, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  '${item.product.price} CFA',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          _quantityControl(item),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.blue),
            onPressed: () {
              setState(() {
                CartData.items.remove(item);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _quantityControl(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () {
              setState(() {
                if (item.quantity > 1) item.quantity--;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(item.quantity.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () {
              setState(() {
                item.quantity++;
              });
            },
          ),
        ],

      ),
    );
  }

  // ================= TOTAL =================
  Widget _totalSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

        Text(
          '$totalPrice CFA',
          style: const TextStyle(
              fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ================= BUTTONS =================
  Widget _bottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            label: const Text('Retour au magasin',
                style: TextStyle(color: Colors.blue)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),

            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, checkout);
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text('Continuer au details',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),

            ),
          ),
        ),
      ],
    );
  }
}
