import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/products/firestore_product_repository.dart';
import '../../domain/models/product.dart';
import '../../domain/products/product_repository.dart';
import 'firebase_providers.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreProductRepository(firestore);
});

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).watchAll();
});
