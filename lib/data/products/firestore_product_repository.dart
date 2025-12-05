import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/product.dart';
import '../../domain/products/product_repository.dart';

class FirestoreProductRepository implements ProductRepository {
  FirestoreProductRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('products');

  @override
  String createId() => _collection.doc().id;

  @override
  Future<bool> skuExists(String sku, {String? excludeId}) async {
    final normalized = sku.trim();
    if (normalized.isEmpty) return false;
    final snapshot = await _collection
        .where('sku', isEqualTo: normalized)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return false;
    final doc = snapshot.docs.first;
    if (excludeId != null && doc.id == excludeId) return false;
    return true;
  }

  @override
  Stream<List<Product>> watchAll() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> upsert(Product product) {
    return _collection.doc(product.id).set(product.toMap(), SetOptions(merge: true));
  }

  @override
  Future<void> delete(String id) {
    return _collection.doc(id).delete();
  }
}
