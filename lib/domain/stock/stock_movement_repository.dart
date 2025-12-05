import '../models/stock_movement.dart';

abstract class StockMovementRepository {
  Stream<List<StockMovement>> watchRecent({int limit});
  String createId();
  Future<void> record(StockMovement movement);
}
