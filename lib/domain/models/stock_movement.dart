class StockMovement {
  const StockMovement({
    required this.id,
    required this.productId,
    required this.warehouseId,
    required this.quantityDelta,
    required this.reason,
    required this.createdAt,
    this.referenceId,
    this.createdBy,
  });

  final String id;
  final String productId;
  final String warehouseId;
  final double quantityDelta;
  final String reason;
  final DateTime createdAt;
  final String? referenceId;
  final String? createdBy;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'warehouseId': warehouseId,
      'quantityDelta': quantityDelta,
      'reason': reason,
      'referenceId': referenceId,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory StockMovement.fromMap(String id, Map<String, dynamic> data) {
    return StockMovement(
      id: id,
      productId: data['productId'] as String? ?? '',
      warehouseId: data['warehouseId'] as String? ?? '',
      quantityDelta: (data['quantityDelta'] as num?)?.toDouble() ?? 0,
      reason: data['reason'] as String? ?? 'unknown',
      referenceId: data['referenceId'] as String?,
      createdBy: data['createdBy'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (data['createdAt'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
