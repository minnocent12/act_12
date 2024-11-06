import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/add_product_screen.dart';
import '../screens/edit_product_screen.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Inventory", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              },
              child: Text(
                "Add New Item",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: firestoreService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.0),
                  title: Text(product.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category: ${product.category}"),
                      Text("Stock: ${product.stock}"),
                    ],
                  ),
                  trailing: Text("\$${product.price}",
                      style: TextStyle(color: Colors.green)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProductScreen(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
