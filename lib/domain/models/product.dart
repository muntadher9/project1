class Product {
  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    this.barcode,
    this.cost,
    this.minStock,
    this.trackSerial = false,
    this.trackExpiry = false,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String sku;
  final double price;
  final String? barcode;
  final double? cost;
  final double? minStock;
  final bool trackSerial;
  final bool trackExpiry;
  final String? imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sku': sku,
      'price': price,
      'barcode': barcode,
      'cost': cost,
      'minStock': minStock,
      'trackSerial': trackSerial,
      'trackExpiry': trackExpiry,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] as String? ?? 'Unnamed',
      sku: data['sku'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      barcode: data['barcode'] as String?,
      cost: (data['cost'] as num?)?.toDouble(),
      minStock: (data['minStock'] as num?)?.toDouble(),
      trackSerial: data['trackSerial'] as bool? ?? false,
      trackExpiry: data['trackExpiry'] as bool? ?? false,
      imageUrl: data['imageUrl'] as String?,
    );
  }
}
