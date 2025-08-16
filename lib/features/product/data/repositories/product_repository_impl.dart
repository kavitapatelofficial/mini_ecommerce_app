
import 'package:mini_ecommerce/core/utils/helper.dart';
import 'package:mini_ecommerce/features/product/data/datasources/product_local_datasource.dart';
import 'package:mini_ecommerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:mini_ecommerce/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';


import 'package:connectivity_plus/connectivity_plus.dart';


class ProductRepositoryImpl {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;
  final Connectivity connectivity;

  ProductRepositoryImpl({
    required this.remote,
    required this.local,
    required this.connectivity,
  });

Future<List<Product>> getProducts() async {
  try {
    final connResult = await connectivity.checkConnectivity();
    if (connResult != ConnectivityResult.none) {
      final products = await remote.fetchProducts();

      // 🔹 Download images
      final updatedProducts = <ProductModel>[];
      for (var p in products) {
        final path = await downloadAndSaveImage(p.image, 'product_${p.id}.png');
        updatedProducts.add(ProductModel(
          id: p.id,
          title: p.title,
          image: p.image,
          description: p.description,
          price: p.price,
          localImagePath: path,
        ));
      }

      await local.cacheProducts(updatedProducts);
      return updatedProducts;
    } else {
      final cached = await local.getCachedProducts();
      return cached; // offline use
    }
  } catch (_) {
    final cached = await local.getCachedProducts();
    return cached;
  }
}




}

