import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'supply.dart'; // pour Product, CartItem, CartData

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartData.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 12),
          Icon(Icons.person_outline),
          SizedBox(width: 12),
        ],
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
                  ? const Center(child: Text('Your cart is empty'))
                  : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _cartItem(item);
                },
              ),
            ),

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
            Text('Shopping Cart', style: TextStyle(fontSize: 12)),
            Text('Checkout Details', style: TextStyle(fontSize: 12)),
            Text('Payment', style: TextStyle(fontSize: 12)),
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
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(item.product.image, height: 50),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  '${item.product.price} CFA',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
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
            icon: const Icon(Icons.remove, size: 16),
            onPressed: () {
              setState(() {
                if (item.quantity > 1) {
                  item.quantity--;
                }
              });
            },
          ),
          Text(item.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
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
    final total = CartData.items.fold(
      0,
          (sum, item) => sum + item.product.price * item.quantity,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Total:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        Text(
          '$total CFA',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            label: const Text('Continue Shopping',
                style: TextStyle(color: Colors.blue)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 14),
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
            label: const Text('Continue to Checkout',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}