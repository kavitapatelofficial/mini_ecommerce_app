import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mini_ecommerce/features/product/data/datasources/product_local_datasource.dart';
import 'package:mini_ecommerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:mini_ecommerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';




// Providers
final _dioProvider = Provider((_) => Dio());
final _connectivityProvider = Provider((_) => Connectivity());

// Hive-based local datasource
final _productLocalProvider = Provider<ProductLocalDataSource>((_) {
  return ProductLocalDataSourceImpl(); // make sure Hive.init() already called in main
});

// Repository provider
final productRepoProvider = Provider<ProductRepositoryImpl>((ref) {
  final dio = ref.read(_dioProvider);
  final connectivity = ref.read(_connectivityProvider);
  final local = ref.read(_productLocalProvider);

  final remote = ProductRemoteDataSourceImpl(dio);

  return ProductRepositoryImpl(
    remote: remote,
    local: local,
    connectivity: connectivity,
  );
});

// Offline-ready FutureProvider
final getProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepoProvider);

  try {
    final products = await repo.getProducts();
    // agar products empty nahi → Hive me cache automatically save ho chuka hai
    return products;
  } catch (e) {
    // koi error aaya → try cache
    final cached = await repo.local.getCachedProducts();
    return cached; // agar cache bhi empty → empty list
  }
});
