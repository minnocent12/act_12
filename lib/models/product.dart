class Product {
  String id;
  String name;
  String category;
  String supplier;
  int stock;
  int price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.supplier,
    required this.stock,
    required this.price,
  });

  // Create a Product from Firestore document data
  factory Product.fromFirestore(Map<String, dynamic> firestoreData, String id) {
    return Product(
      id: id,
      name: firestoreData['name'],
      category: firestoreData['category'],
      supplier: firestoreData['supplier'],
      stock: firestoreData['stock'],
      price: firestoreData['price'],
    );
  }

  // Convert Product to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'supplier': supplier,
      'stock': stock,
      'price': price,
    };
  }
}
