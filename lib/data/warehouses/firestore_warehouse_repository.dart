import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/warehouse.dart';
import '../../domain/warehouses/warehouse_repository.dart';

class FirestoreWarehouseRepository implements WarehouseRepository {
  FirestoreWarehouseRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('warehouses');

  @override
  String createId() => _collection.doc().id;

  @override
  Stream<List<Warehouse>> watchAll() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Warehouse.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> upsert(Warehouse warehouse) {
    return _collection.doc(warehouse.id).set(
          warehouse.toMap(),
          SetOptions(merge: true),
        );
  }

  @override
  Future<void> delete(String id) {
    return _collection.doc(id).delete();
  }
}
