import '../models/product.dart';

abstract class ProductRepository {
  Stream<List<Product>> watchAll();
  String createId();
  Future<bool> skuExists(String sku, {String? excludeId});
  Future<void> upsert(Product product);
  Future<void> delete(String id);
}
