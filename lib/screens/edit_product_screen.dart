import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final _formKey = GlobalKey<FormState>();

  final _nameController;
  final _categoryController;
  final _supplierController;
  final _stockController;
  final _priceController;

  final FirestoreService firestoreService = FirestoreService();

  EditProductScreen({required this.product})
      : _nameController = TextEditingController(text: product.name),
        _categoryController = TextEditingController(text: product.category),
        _supplierController = TextEditingController(text: product.supplier),
        _stockController =
            TextEditingController(text: product.stock.toString()),
        _priceController =
            TextEditingController(text: product.price.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product")),
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
                    final updatedProduct = Product(
                      id: product.id,
                      name: _nameController.text,
                      category: _categoryController.text,
                      supplier: _supplierController.text,
                      stock: int.parse(_stockController.text),
                      price: int.parse(_priceController.text),
                    );
                    await firestoreService.updateProduct(
                        updatedProduct); // Update product in Firestore
                    Navigator.pop(context); // Go back to HomeScreen
                  }
                },
                child: Text("Update Product"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await firestoreService.deleteProduct(
                      product.id); // Delete product from Firestore
                  Navigator.pop(context); // Go back to HomeScreen
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Delete Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
