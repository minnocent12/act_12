class Supplier {
  String id;
  String name;
  String contactInfo;
  String address;

  Supplier({
    required this.id,
    required this.name,
    required this.contactInfo,
    required this.address,
  });

  factory Supplier.fromFirestore(Map<String, dynamic> data, String id) {
    return Supplier(
      id: id,
      name: data['name'],
      contactInfo: data['contactInfo'],
      address: data['address'],
    );
  }
}
