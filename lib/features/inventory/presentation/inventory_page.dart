import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/product_providers.dart';
import '../../../core/providers/stock_movement_providers.dart';
import '../../../core/providers/warehouse_providers.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/stock_movement.dart';
import '../../../domain/models/warehouse.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehouses = ref.watch(warehousesStreamProvider);
    final movements = ref.watch(stockMovementsStreamProvider(50));
    final products = ref.watch(productsStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Warehouses',
                  style: Theme.of(context).textTheme.headlineSmall),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add warehouse'),
                onPressed: () => _openWarehouseEditor(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Add sample data'),
            onPressed: () => _seedSampleData(context, ref),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300,
            child: warehouses.when(
              data: (items) => WarehouseList(items: items, ref: ref),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Stock movements',
                  style: Theme.of(context).textTheme.headlineSmall),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Record movement'),
                onPressed: () => _openMovementEditor(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 12),
          movements.when(
            data: (items) => products.when(
              data: (productList) => warehouses.when(
                data: (warehouseList) => StockMovementList(
                  movements: items,
                  products: productList,
                  warehouses: warehouseList,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}

class WarehouseList extends StatelessWidget {
  const WarehouseList({super.key, required this.items, required this.ref});
  final List<Warehouse> items;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No warehouses yet'));
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final warehouse = items[index];
        return ListTile(
          leading: const Icon(Icons.home_work_outlined),
          title: Text(warehouse.name),
          subtitle: Text(
            warehouse.address?.isNotEmpty == true
                ? warehouse.address!
                : 'No address',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    _openWarehouseEditor(context, ref, warehouse: warehouse),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete warehouse'),
                          content: Text(
                              'Delete "${warehouse.name}"? This cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton.tonal(
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                  if (!confirm) return;
                  try {
                    await ref
                        .read(warehouseRepositoryProvider)
                        .delete(warehouse.id);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Warehouse deleted')),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Delete failed: $e')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _openWarehouseEditor(
  BuildContext context,
  WidgetRef ref, {
  Warehouse? warehouse,
}) async {
  final repo = ref.read(warehouseRepositoryProvider);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: warehouse?.name ?? '');
  final addressController =
      TextEditingController(text: warehouse?.address ?? '');

  await showDialog(
    context: context,
    builder: (context) {
      String? formError;
      bool saving = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(warehouse == null ? 'New warehouse' : 'Edit warehouse'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.home_work_outlined),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Name is required'
                          : null,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.place_outlined),
                  ),
                ),
                if (formError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    formError!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: saving ? null : () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: saving
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;
                      setState(() {
                        saving = true;
                        formError = null;
                      });
                      final entity = Warehouse(
                        id: warehouse?.id ?? repo.createId(),
                        name: nameController.text.trim(),
                        address: addressController.text.trim().isEmpty
                            ? null
                            : addressController.text.trim(),
                        branchId: warehouse?.branchId,
                      );
                      try {
                        await repo.upsert(entity);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(warehouse == null
                                ? 'Warehouse added'
                                : 'Warehouse updated'),
                          ),
                        );
                      } catch (e) {
                        setState(() {
                          formError = 'Save failed: $e';
                          saving = false;
                        });
                      }
                    },
              child: saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

class StockMovementList extends StatelessWidget {
  const StockMovementList({
    super.key,
    required this.movements,
    required this.products,
    required this.warehouses,
  });

  final List<StockMovement> movements;
  final List<Product> products;
  final List<Warehouse> warehouses;

  @override
  Widget build(BuildContext context) {
    if (movements.isEmpty) {
      return const Center(child: Text('No movements yet'));
    }

    final productById = {for (final p in products) p.id: p};
    final warehouseById = {for (final w in warehouses) w.id: w};

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movements.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final m = movements[index];
            final product = productById[m.productId];
            final warehouse = warehouseById[m.warehouseId];
            final qty = m.quantityDelta;
            final isOut = qty < 0;
            return ListTile(
              leading: Icon(
                isOut ? Icons.call_made : Icons.call_received,
                color: isOut
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                product?.name ?? m.productId,
                overflow: TextOverflow.ellipsis,
              ),
          subtitle: Text(
            '${warehouse?.name ?? m.warehouseId} • ${m.reason} • ${m.createdAt}',
          ),
          trailing: Text(
            qty.toStringAsFixed(2),
            style: TextStyle(
              color: isOut
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

Future<void> _openMovementEditor(
  BuildContext context,
  WidgetRef ref, {
  StockMovement? movement,
}) async {
  final products = await ref.read(productsStreamProvider.future);
  final warehouses = await ref.read(warehousesStreamProvider.future);
  if (products.isEmpty || warehouses.isEmpty) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add products and warehouses first')),
    );
    return;
  }
  if (!context.mounted) return;

  final movementRepo = ref.read(stockMovementRepositoryProvider);
  final formKey = GlobalKey<FormState>();
  String? selectedProductId = movement?.productId ?? products.first.id;
  String? selectedWarehouseId = movement?.warehouseId ?? warehouses.first.id;
  final qtyController = TextEditingController(
    text: movement?.quantityDelta.toString() ?? '',
  );
  final reasonController = TextEditingController(text: movement?.reason ?? '');

  await showDialog(
    context: context,
    builder: (context) {
      String? formError;
      bool saving = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Record movement'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selectedProductId,
                  decoration: const InputDecoration(
                    labelText: 'Product',
                    prefixIcon: Icon(Icons.inventory_2_outlined),
                  ),
                  items: products
                      .map((p) => DropdownMenuItem(
                            value: p.id,
                            child: Text(p.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    selectedProductId = value;
                  }),
                ),
                DropdownButtonFormField<String>(
                  initialValue: selectedWarehouseId,
                  decoration: const InputDecoration(
                    labelText: 'Warehouse',
                    prefixIcon: Icon(Icons.home_work_outlined),
                  ),
                  items: warehouses
                      .map((w) => DropdownMenuItem(
                            value: w.id,
                            child: Text(w.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    selectedWarehouseId = value;
                  }),
                ),
                TextFormField(
                  controller: qtyController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity delta (use negative for out)',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    final parsed = double.tryParse(text);
                    if (parsed == null || parsed == 0) {
                      return 'Enter a non-zero number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Reason is required'
                          : null,
                ),
                if (formError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    formError!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: saving ? null : () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: saving
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;
                      if (selectedProductId == null ||
                          selectedWarehouseId == null) {
                        return;
                      }
                      setState(() {
                        saving = true;
                        formError = null;
                      });
                      final movementEntity = StockMovement(
                        id: movement?.id ?? movementRepo.createId(),
                        productId: selectedProductId!,
                        warehouseId: selectedWarehouseId!,
                        quantityDelta:
                            double.parse(qtyController.text.trim()),
                        reason: reasonController.text.trim(),
                        createdAt: DateTime.now(),
                        createdBy: null,
                      );
                      try {
                        await movementRepo.record(movementEntity);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Movement recorded')),
                        );
                      } catch (e) {
                        setState(() {
                          formError = 'Save failed: $e';
                          saving = false;
                        });
                      }
                    },
              child: saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _seedSampleData(BuildContext context, WidgetRef ref) async {
  final productRepo = ref.read(productRepositoryProvider);
  final warehouseRepo = ref.read(warehouseRepositoryProvider);
  final movementRepo = ref.read(stockMovementRepositoryProvider);

  try {
    final w1 = Warehouse(
      id: warehouseRepo.createId(),
      name: 'Main Warehouse',
      address: 'Central',
    );
    final w2 = Warehouse(
      id: warehouseRepo.createId(),
      name: 'Branch Warehouse',
      address: 'Branch',
    );
    await warehouseRepo.upsert(w1);
    await warehouseRepo.upsert(w2);

    final p1 = Product(
      id: productRepo.createId(),
      name: 'Sample Item A',
      sku: 'SMP-A',
      price: 25,
    );
    final p2 = Product(
      id: productRepo.createId(),
      name: 'Sample Item B',
      sku: 'SMP-B',
      price: 40,
    );
    await productRepo.upsert(p1);
    await productRepo.upsert(p2);

    await movementRepo.record(
      StockMovement(
        id: movementRepo.createId(),
        productId: p1.id,
        warehouseId: w1.id,
        quantityDelta: 10,
        reason: 'Initial stock',
        createdAt: DateTime.now(),
      ),
    );
    await movementRepo.record(
      StockMovement(
        id: movementRepo.createId(),
        productId: p2.id,
        warehouseId: w2.id,
        quantityDelta: -3,
        reason: 'Adjustment',
        createdAt: DateTime.now(),
      ),
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sample data added')),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sample data failed: $e')),
    );
  }
}
