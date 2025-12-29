// ignore_for_file: unused_import

import 'package:cours1/src/ui/routes/route_path.dart';
import 'package:cours1/src/ui/screens/login/login.dart';
import 'package:cours1/src/ui/screens/supply/supply.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String userName;
  final String userEmail;

  const Home({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentCarouselIndex = 0;
  int _selectedTabIndex = 0;

  final List<String> tabs = ['Tous', 'Produits', 'Categorie', 'Promotions'];

  final List<String> carouselImages = [
    'assets/images/promo1.jpg',
    'assets/images/promo2.jpg',
    'assets/images/promo3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    _buildTabs(),
                    const SizedBox(height: 20),
                    _buildCarousel(),
                    const SizedBox(height: 10),
                    _buildCarouselIndicators(),
                    const SizedBox(height: 30),
                    _buildMainMenu(),
                    const SizedBox(height: 20),
            
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildChatButton(),
    );
  }

  // ================= DRAWER =================
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            accountName: Text(widget.userName),
            accountEmail: Text(widget.userEmail),
          ),
          _drawerItem(Icons.home, 'Accueil', () => Navigator.pop(context)),
          _drawerItem(Icons.favorite, 'Favorie', () => Navigator.pop(context)),
          _drawerItem(Icons.shopping_cart, 'card',() => Navigator.pop(context) ),
          _drawerItem(Icons.person, 'Profil', () => Navigator.pop(context)),
          const Divider(),
          _drawerItem(Icons.logout, 'Déconnexion', _showLogoutDialog,
              color: Colors.blue),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      onTap: onTap,
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          const Text('Accueil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {

            },
          ),
         
        ],
          

          
        
      ),
    );
  }

  // ================= SEARCH =================
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= TABS =================
  Widget _buildTabs() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        itemBuilder: (_, i) {
          final selected = _selectedTabIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = i),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? Colors.blue[50] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: selected ? Colors.blue : Colors.grey[300]!),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                    color: selected ? Colors.blue : Colors.grey[700],
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= CAROUSEL =================
  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: carouselImages.length,
        onPageChanged: (index) {
          setState(() => _currentCarouselIndex = index);
        },
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(carouselImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: carouselImages.asMap().entries.map((e) {
        return Container( 
          width: _currentCarouselIndex == e.key ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentCarouselIndex == e.key
                ? Colors.orange
                : Colors.grey[300],
          ),
        );
      }).toList(),
    );
  }

  // ================= MENU =================
 Widget _buildMainMenu() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        _menuItem(
          Icons.local_shipping,
          'Supply',
          () {
            Navigator.pushNamed(context, supply); // route Produits
          },
        ),
        const SizedBox(width: 12),
        _menuItem(
          Icons.inventory_2,
          'Inventory',
          () {
            // Navigator.pushNamed(context, products);
          },
        ),
        const SizedBox(width: 12),
        _menuItem(
          Icons.point_of_sale,
          'Cahier',
          () {
            // Navigator.pushNamed(context, products);
          },
        ),
      ],
    ),
  );
}


 Widget _menuItem(
  IconData icon,
  String label,
  VoidCallback onTap,
) {
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    ),
  );
}




  // ================= CHAT =================
  Widget _buildChatButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('Ask Now'),
      onPressed: () {},
    );
  }

  // ================= LOGOUT =================
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}
