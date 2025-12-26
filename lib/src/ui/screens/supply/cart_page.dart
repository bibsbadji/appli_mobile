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
      backgroundColor: Colors.white,

      appBar: _appBar(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CheckoutStepper(),

            const SizedBox(height: 20),

            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty 🛒',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: cartItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) => CartItemCard(
                        item: cartItems[index],
                        onUpdate: () => setState(() {}),
                        onDelete: () {
                          setState(() {
                            cartItems.removeAt(index);
                          });
                        },
                      ),
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

  // ================= APPBAR =================
  AppBar _appBar() {
    return AppBar(
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
    );
  }

  // ================= TOTAL =================
  Widget _totalSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          '$totalPrice CFA',
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            label: const Text(
              'Continue Shopping',
              style: TextStyle(color: Colors.blue),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: cartItems.isEmpty
                ? null
                : () => Navigator.pushNamed(context, checkout),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Continue to Checkout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// STEPPER
////////////////////////////////////////////////////////////

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            StepCircle(active: true),
            StepLine(),
            StepCircle(),
            StepLine(),
            StepCircle(),
          ],
        ),
        SizedBox(height: 6),
        Row(
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
}

class StepCircle extends StatelessWidget {
  final bool active;
  const StepCircle({super.key, this.active = false});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: active ? Colors.blue : Colors.grey.shade300,
      child: active
          ? const CircleAvatar(radius: 4, backgroundColor: Colors.white)
          : null,
    );
  }
}

class StepLine extends StatelessWidget {
  const StepLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(height: 2, color: Colors.grey.shade300));
  }
}

////////////////////////////////////////////////////////////
/// CART ITEM
////////////////////////////////////////////////////////////

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
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

          QuantityControl(item: item, onUpdate: onUpdate),

          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.blue),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class QuantityControl extends StatelessWidget {
  final CartItem item;
  final VoidCallback onUpdate;

  const QuantityControl({
    super.key,
    required this.item,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
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
              if (item.quantity > 1) {
                item.quantity--;
                onUpdate();
              }
            },
          ),
          Text(item.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: () {
              item.quantity++;
              onUpdate();
            },
          ),
        ],
      ),
    );
  }
}
