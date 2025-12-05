import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/stock_movement.dart';
import '../../domain/stock/stock_movement_repository.dart';

class FirestoreStockMovementRepository implements StockMovementRepository {
  FirestoreStockMovementRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('stock_movements');

  @override
  String createId() => _collection.doc().id;

  @override
  Stream<List<StockMovement>> watchRecent({int limit = 50}) {
    return _collection
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => StockMovement.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> record(StockMovement movement) {
    return _collection.doc(movement.id).set(movement.toMap());
  }
}
