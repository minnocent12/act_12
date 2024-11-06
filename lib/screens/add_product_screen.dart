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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Product Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                label: 'Product Name',
                hintText: 'Enter the product name',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a product name' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _categoryController,
                label: 'Category',
                hintText: 'Enter product category',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a category' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _supplierController,
                label: 'Supplier',
                hintText: 'Enter supplier name',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a supplier' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _stockController,
                label: 'Stock Quantity',
                hintText: 'Enter available stock',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter stock quantity' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _priceController,
                label: 'Price',
                hintText: 'Enter product price',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a price' : null,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
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
                      await firestoreService.addProduct(product);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.teal.shade700),
        filled: true,
        fillColor: Colors.teal.shade50,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.teal.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
      validator: validator,
    );
  }
}
