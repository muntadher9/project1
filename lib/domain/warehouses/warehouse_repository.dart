import '../models/warehouse.dart';

abstract class WarehouseRepository {
  Stream<List<Warehouse>> watchAll();
  String createId();
  Future<void> upsert(Warehouse warehouse);
  Future<void> delete(String id);
}
