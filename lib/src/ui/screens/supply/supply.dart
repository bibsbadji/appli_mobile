import 'package:flutter/material.dart';
import 'package:cours1/src/utiles/my_assets/images_assets.dart';
import 'package:cours1/src/ui/screens/supply/cart_page.dart';
import '../../widgets/forms/product_card/product_card.dart';

/// =====================
/// MODELS (DANS LE MEME FICHIER)
/// =====================

class Product {
  final String name;
  final String image;
  final int price;

  Product({
    required this.name,
    required this.image,
    required this.price,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartData {
  static List<CartItem> items = [];

  static void addToCart(Product product) {
    final index =
    items.indexWhere((item) => item.product.name == product.name);

    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(CartItem(product: product));
    }
  }
}

/// =====================
/// SUPPLY PAGE
/// =====================

class Supply extends StatefulWidget {
  const Supply({super.key});

  @override
  State<Supply> createState() => _SupplyState();
}

class _SupplyState extends State<Supply> {
  int _selectedIndex = 0;

  /// Produits
  final List<Product> products = [
    Product(name: 'NESCOFFE', image: ImagesAssets.coffe, price: 200),
    Product(name: 'M&MS', image: ImagesAssets.mms, price: 200),
    Product(name: 'PRINGELS', image: ImagesAssets.pringels, price: 200),
    Product(name: 'CHOCOLATE', image: ImagesAssets.chocolate, price: 200),
    Product(name: 'OREO', image: ImagesAssets.oreo, price: 200),
    Product(
        name: 'STRAWBERRY JUICE',
        image: ImagesAssets.strawberry,
        price: 200),
    Product(name: 'NUTELLA', image: ImagesAssets.nutella, price: 200),
    Product(name: 'FANTA', image: ImagesAssets.fanta, price: 200),
  ];

  /// Nombre total d’articles dans le panier (badge)
  int get cartItemCount {
    return CartData.items.fold(
      0,
          (sum, item) => sum + item.quantity,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartPage()),
      ).then((_) {
        setState(() {}); // rafraîchir le badge au retour
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Supply', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          /// PANIER + BADGE
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),

              if (cartItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItemCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: Colors.blue),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onAddToCart: () {
                setState(() {
                  CartData.addToCart(products[index]);
                });
              },
            );
          },
        ),
      ),

      /// BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}