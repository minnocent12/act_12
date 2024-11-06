class Category {
  String id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromFirestore(Map<String, dynamic> data, String id) {
    return Category(
      id: id,
      name: data['name'],
    );
  }
}
