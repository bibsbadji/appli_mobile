import 'package:flutter/material.dart';
import '../../../screens/supply/supply.dart'; // <-- pour utiliser Product

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.favorite_border, size: 18),
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  product.image,
                  height: 80,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "${product.price} CFA",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            /// Boutons quantité (UI seulement pour l’instant)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _quantityButton(Icons.remove),
                const Text("1"),
                _quantityButton(Icons.add),
              ],
            ),

            const SizedBox(height: 10),

            /// ADD TO CART FONCTIONNEL
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAddToCart,
                icon: const Icon(Icons.shopping_cart, size: 16, color: Colors.white),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 16),
    );
  }
}
