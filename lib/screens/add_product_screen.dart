import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class AddProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _supplierController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category')),
              TextFormField(
                  controller: _supplierController,
                  decoration: InputDecoration(labelText: 'Supplier')),
              TextFormField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id: '',
                      name: _nameController.text,
                      category: _categoryController.text,
                      supplier: _supplierController.text,
                      stock: int.parse(_stockController.text),
                      price: int.parse(_priceController.text),
                    );
                    await firestoreService
                        .addProduct(product); // Add product to Firestore
                    Navigator.pop(context); // Go back to the HomeScreen
                  }
                },
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
