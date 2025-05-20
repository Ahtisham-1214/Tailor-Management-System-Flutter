import 'package:flutter/material.dart';
import 'package:tailor_management/customer_screen.dart';
import 'package:tailor_management/shop_detail_screen.dart';
import 'main.dart';
import 'prices_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      // === Drawer Sidebar Added Here ===
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Text(
                'Navigation Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.price_change),
              title: const Text('Pricing'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PriceScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Shop Details'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ShopDetailScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add), // Added Add button with a plus icon
              label: const Text('Add'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerScreen()));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
