import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class FirestoreService {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('product');

  // Get the list of products as a stream (real-time updates)
  Stream<List<Product>> getProducts() {
    return _productCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Add a new product to Firestore
  Future<void> addProduct(Product product) async {
    await _productCollection.add(product.toFirestore());
  }

  // Update an existing product in Firestore
  Future<void> updateProduct(Product product) async {
    await _productCollection.doc(product.id).update(product.toFirestore());
  }

  // Delete a product from Firestore
  Future<void> deleteProduct(String id) async {
    await _productCollection.doc(id).delete();
  }
}
