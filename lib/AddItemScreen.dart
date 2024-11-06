import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Item")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Product Name"),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: "Category"),
                items: [
                  DropdownMenuItem(
                      child: Text("Electronics"), value: "Electronics"),
                  DropdownMenuItem(child: Text("Clothing"), value: "Clothing"),
                ],
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add item to Firestore
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
