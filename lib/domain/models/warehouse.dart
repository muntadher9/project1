class Warehouse {
  const Warehouse({
    required this.id,
    required this.name,
    this.branchId,
    this.address,
  });

  final String id;
  final String name;
  final String? branchId;
  final String? address;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'branchId': branchId,
      'address': address,
    };
  }

  factory Warehouse.fromMap(String id, Map<String, dynamic> data) {
    return Warehouse(
      id: id,
      name: data['name'] as String? ?? 'Warehouse',
      branchId: data['branchId'] as String?,
      address: data['address'] as String?,
    );
  }
}
