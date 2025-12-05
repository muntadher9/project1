import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/product_providers.dart';
import '../../../domain/models/product.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  int _visibleCount = 20;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsStreamProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: products.when(
          data: (items) => _ProductsList(
            items: items.take(_visibleCount).toList(),
            ref: ref,
            onLoadMore: items.length > _visibleCount
                ? () => setState(() => _visibleCount += 20)
                : null,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    required this.items,
    required this.ref,
    this.onLoadMore,
  });
  final List<Product> items;
  final WidgetRef ref;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No products yet'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = items[index];
              return ListTile(
                leading: _ProductIcon(product: product),
                title: Text(product.name),
                subtitle: Text(product.sku.isEmpty ? 'No SKU' : product.sku),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(product.price.toStringAsFixed(2)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete product'),
                                content: Text(
                                    'Are you sure you want to delete "${product.name}"?'),
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
                              .read(productRepositoryProvider)
                              .delete(product.id);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product deleted')),
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
                onTap: () => _openEditor(context, ref, product: product),
              );
            },
          ),
        ),
        if (onLoadMore != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: onLoadMore,
              child: const Text('Load more'),
            ),
          ),
      ],
    );
  }
}

class _ProductIcon extends StatelessWidget {
  const _ProductIcon({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final icons = <IconData>[
      Icons.inventory_2_outlined,
      Icons.shopping_bag_outlined,
      Icons.local_offer_outlined,
      Icons.devices_outlined,
      Icons.cottage_outlined,
    ];
    final colors = <Color>[
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    final hash = product.sku.hashCode;
    final icon = icons[hash.abs() % icons.length];
    final color = colors[hash.abs() % colors.length];
    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(icon, color: color),
    );
  }
}

Future<void> _openEditor(
  BuildContext context,
  WidgetRef ref, {
  Product? product,
}) async {
  final repo = ref.read(productRepositoryProvider);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: product?.name ?? '');
  final skuController = TextEditingController(text: product?.sku ?? '');
  final priceController =
      TextEditingController(text: product?.price.toString() ?? '');

  await showDialog(
    context: context,
    builder: (context) {
      String? formError;
      bool saving = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(product == null ? 'New product' : 'Edit product'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.label_outline),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Name is required' : null,
                ),
                TextFormField(
                  controller: skuController,
                  decoration: const InputDecoration(
                    labelText: 'SKU',
                    prefixIcon: Icon(Icons.qr_code_2),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'SKU is required';
                    }
                    if (value.trim().length < 3) {
                      return 'SKU should be at least 3 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    final parsed = double.tryParse(text);
                    if (parsed == null || parsed <= 0) {
                      return 'Enter a price greater than 0';
                    }
                    return null;
                  },
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
                      final sku = skuController.text.trim();
                      final price = double.parse(priceController.text.trim());
                      setState(() {
                        formError = null;
                        saving = true;
                      });
                      try {
                        final exists =
                            await repo.skuExists(sku, excludeId: product?.id);
                        if (exists) {
                          setState(() {
                            formError = 'SKU already exists';
                            saving = false;
                          });
                          return;
                        }
                        final entity = Product(
                          id: product?.id ?? repo.createId(),
                          name: nameController.text.trim(),
                          sku: sku,
                          price: price,
                        );
                        await repo.upsert(entity);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(product == null
                                ? 'Product added'
                                : 'Product updated'),
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
