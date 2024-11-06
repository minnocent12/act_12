import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController;
  final TextEditingController _categoryController;
  final TextEditingController _supplierController;
  final TextEditingController _stockController;
  final TextEditingController _priceController;

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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:
            Text("Edit Product", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modify Product Details",
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
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
                          await firestoreService.updateProduct(updatedProduct);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Update Product",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await firestoreService.deleteProduct(product.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Delete Product",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
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
