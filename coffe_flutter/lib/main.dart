import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

// Entry point of the application
void main() {
  runApp(MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Store',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CatalogPage(),
    );
  }
}

// Stateful widget for the catalog page
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  // List of products to display in the catalog
  final List<Product> products = [
    Product(name: 'Product 1', imageUrl: 'https://picsum.photos/200', price: 19.99),
    Product(name: 'Product 2', imageUrl: 'https://picsum.photos/201', price: 29.99),
    Product(name: 'Product 3', imageUrl: 'https://picsum.photos/202', price: 39.99),
    Product(name: 'Product 4', imageUrl: 'https://picsum.photos/201', price: 29.99),
    Product(name: 'Product 5', imageUrl: 'https://picsum.photos/202', price: 39.99),
    // Add more products as needed
  ];

  // State variable to track dark mode
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
                Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
              });
            },
          ),
        ],
      ),
      // Grid view to display products
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1.0,
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }
}

// Widget to display individual product cards
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Show dialog when tapping on a product
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(product.name),
            content: Text('You selected ${product.name}'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Product details
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}