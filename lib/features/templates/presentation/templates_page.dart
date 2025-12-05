import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/product_providers.dart';
import '../../../core/providers/stock_movement_providers.dart';
import '../../../core/providers/warehouse_providers.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/stock_movement.dart';
import '../../../domain/models/warehouse.dart';

class TemplatesPage extends ConsumerWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = [
      SampleTemplate(
        name: 'Retail essentials',
        description: 'Two warehouses + 3 products with basic stock in/out.',
        warehouses: const [
          ('Main Warehouse', 'City center'),
          ('Outlet', 'Mall branch'),
        ],
        products: const [
          ('Blue T-Shirt', 'TSH-BLU', 15.0),
          ('Jeans', 'JEANS-32', 45.0),
          ('Sneakers', 'SNK-01', 60.0),
        ],
        movements: const [
          MovementSeed(productIndex: 0, warehouseIndex: 0, qty: 30, reason: 'Initial stock'),
          MovementSeed(productIndex: 1, warehouseIndex: 0, qty: 15, reason: 'Initial stock'),
          MovementSeed(productIndex: 2, warehouseIndex: 1, qty: 8, reason: 'Initial stock'),
          MovementSeed(productIndex: 0, warehouseIndex: 1, qty: -3, reason: 'Transfer out'),
        ],
      ),
      SampleTemplate(
        name: 'Cafe / POS',
        description: 'Ingredients and ready items for a small cafe.',
        warehouses: const [
          ('Kitchen', 'Back of house'),
          ('Front fridge', 'Serving area'),
        ],
        products: const [
          ('Espresso Beans 1kg', 'ESP-BEANS', 18.0),
          ('Milk 1L', 'MILK-1L', 1.2),
          ('Croissant', 'CROIS', 2.5),
        ],
        movements: const [
          MovementSeed(productIndex: 0, warehouseIndex: 0, qty: 12, reason: 'Initial stock'),
          MovementSeed(productIndex: 1, warehouseIndex: 1, qty: 24, reason: 'Initial stock'),
          MovementSeed(productIndex: 2, warehouseIndex: 1, qty: 30, reason: 'Baked fresh'),
          MovementSeed(productIndex: 2, warehouseIndex: 1, qty: -5, reason: 'Sales'),
        ],
      ),
      SampleTemplate(
        name: 'Pharmacy',
        description: 'Front store and storage with fast movers.',
        warehouses: const [
          ('Front store', 'Main counter'),
          ('Storage', 'Backroom'),
        ],
        products: const [
          ('Pain Reliever 24ct', 'PR-24', 6.5),
          ('Vitamin C 500mg', 'VITC-500', 4.2),
          ('Cough Syrup', 'COUGH-250', 5.8),
        ],
        movements: const [
          MovementSeed(productIndex: 0, warehouseIndex: 1, qty: 40, reason: 'Initial stock'),
          MovementSeed(productIndex: 1, warehouseIndex: 1, qty: 25, reason: 'Initial stock'),
          MovementSeed(productIndex: 2, warehouseIndex: 0, qty: 12, reason: 'Initial stock'),
          MovementSeed(productIndex: 0, warehouseIndex: 0, qty: -4, reason: 'Sales'),
        ],
      ),
      SampleTemplate(
        name: 'Electronics shop',
        description: 'Phones, laptops, accessories across main and outlet.',
        warehouses: const [
          ('HQ Store', 'Downtown'),
          ('Outlet', 'Mall'),
        ],
        products: const [
          ('Smartphone X', 'PHONE-X', 799.0),
          ('Laptop Air 13"', 'LAP-AIR13', 1199.0),
          ('Wireless Buds', 'BUDS-WL', 129.0),
          ('USB-C Cable', 'CABLE-USBC', 9.9),
        ],
        movements: const [
          MovementSeed(productIndex: 0, warehouseIndex: 0, qty: 12, reason: 'Initial stock'),
          MovementSeed(productIndex: 1, warehouseIndex: 0, qty: 6, reason: 'Initial stock'),
          MovementSeed(productIndex: 2, warehouseIndex: 1, qty: 20, reason: 'Initial stock'),
          MovementSeed(productIndex: 3, warehouseIndex: 1, qty: 50, reason: 'Initial stock'),
          MovementSeed(productIndex: 0, warehouseIndex: 1, qty: -2, reason: 'Sales'),
        ],
      ),
      SampleTemplate(
        name: 'Grocery mini-mart',
        description: 'Fresh, dry, and chilled items split across storage and front.',
        warehouses: const [
          ('Front display', 'Shelves'),
          ('Back storage', 'Stock room'),
          ('Chiller', 'Cold room'),
        ],
        products: const [
          ('Apples (kg)', 'FRU-APP', 3.5),
          ('Rice 5kg', 'RICE-5', 6.0),
          ('Yogurt 500g', 'YOG-500', 1.2),
          ('Bottled Water 12pk', 'WATER-12', 4.0),
        ],
        movements: const [
          MovementSeed(productIndex: 0, warehouseIndex: 2, qty: 25, reason: 'Initial stock'),
          MovementSeed(productIndex: 1, warehouseIndex: 1, qty: 18, reason: 'Initial stock'),
          MovementSeed(productIndex: 2, warehouseIndex: 2, qty: 30, reason: 'Initial stock'),
          MovementSeed(productIndex: 3, warehouseIndex: 0, qty: 40, reason: 'Initial stock'),
          MovementSeed(productIndex: 0, warehouseIndex: 0, qty: -5, reason: 'Sales'),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            'Starter templates',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Pick a template to auto-create warehouses, products, and sample movements.'),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: templates.map((template) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.withValues(alpha: 0.12),
                              child: const Icon(Icons.layers_outlined, color: Colors.blue),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                template.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(template.description),
                        const SizedBox(height: 12),
                        Text(
                          '${template.warehouses.length} warehouses • ${template.products.length} products • ${template.movements.length} movements',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            for (final p in template.products.take(5))
                              Chip(
                                avatar: _productChipIcon(p.$2),
                                label: Text(p.$1, overflow: TextOverflow.ellipsis),
                              ),
                            if (template.products.length > 5)
                              Chip(
                                avatar: const Icon(Icons.more_horiz),
                                label: Text('+${template.products.length - 5} more'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: () => _applyTemplate(context, ref, template),
                          icon: const Icon(Icons.auto_fix_high),
                          label: const Text('Apply'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SampleTemplate {
  const SampleTemplate({
    required this.name,
    required this.description,
    required this.warehouses,
    required this.products,
    required this.movements,
  });

  final String name;
  final String description;
  final List<(String, String)> warehouses; // name, address
  final List<(String, String, double)> products; // name, sku, price
  final List<MovementSeed> movements;
}

class MovementSeed {
  const MovementSeed({
    required this.productIndex,
    required this.warehouseIndex,
    required this.qty,
    required this.reason,
  });
  final int productIndex;
  final int warehouseIndex;
  final double qty;
  final String reason;
}

Widget _productChipIcon(String sku) {
  final icons = <IconData>[
    Icons.inventory_2_outlined,
    Icons.shopping_bag_outlined,
    Icons.devices_outlined,
    Icons.local_offer_outlined,
    Icons.catching_pokemon,
  ];
  final colors = <Color>[
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  final hash = sku.hashCode.abs();
  final icon = icons[hash % icons.length];
  final color = colors[hash % colors.length];
  return CircleAvatar(
    backgroundColor: color.withValues(alpha: 0.15),
    child: Icon(icon, color: color, size: 18),
  );
}

Future<void> _applyTemplate(
  BuildContext context,
  WidgetRef ref,
  SampleTemplate template,
) async {
  final productRepo = ref.read(productRepositoryProvider);
  final warehouseRepo = ref.read(warehouseRepositoryProvider);
  final movementRepo = ref.read(stockMovementRepositoryProvider);

  try {
    final warehouses = <Warehouse>[];
    for (final w in template.warehouses) {
      final entity = Warehouse(
        id: warehouseRepo.createId(),
        name: w.$1,
        address: w.$2,
      );
      warehouses.add(entity);
      await warehouseRepo.upsert(entity);
    }

    final products = <Product>[];
    for (final p in template.products) {
      final entity = Product(
        id: productRepo.createId(),
        name: p.$1,
        sku: p.$2,
        price: p.$3,
      );
      products.add(entity);
      await productRepo.upsert(entity);
    }

    for (final m in template.movements) {
      if (m.productIndex >= products.length || m.warehouseIndex >= warehouses.length) {
        continue;
      }
      await movementRepo.record(
        StockMovement(
          id: movementRepo.createId(),
          productId: products[m.productIndex].id,
          warehouseId: warehouses[m.warehouseIndex].id,
          quantityDelta: m.qty,
          reason: m.reason,
          createdAt: DateTime.now(),
          createdBy: null,
        ),
      );
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Template "${template.name}" applied')),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Template failed: $e')),
    );
  }
}
