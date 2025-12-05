import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/warehouses/firestore_warehouse_repository.dart';
import '../../domain/models/warehouse.dart';
import '../../domain/warehouses/warehouse_repository.dart';
import 'firebase_providers.dart';

final warehouseRepositoryProvider = Provider<WarehouseRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreWarehouseRepository(firestore);
});

final warehousesStreamProvider = StreamProvider<List<Warehouse>>((ref) {
  return ref.watch(warehouseRepositoryProvider).watchAll();
});
