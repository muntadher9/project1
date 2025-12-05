import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/stock/firestore_stock_movement_repository.dart';
import '../../domain/models/stock_movement.dart';
import '../../domain/stock/stock_movement_repository.dart';
import 'firebase_providers.dart';

final stockMovementRepositoryProvider =
    Provider<StockMovementRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreStockMovementRepository(firestore);
});

final stockMovementsStreamProvider =
    StreamProvider.family<List<StockMovement>, int>((ref, limit) {
  return ref.watch(stockMovementRepositoryProvider).watchRecent(limit: limit);
});
