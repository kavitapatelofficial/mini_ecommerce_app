import 'package:mini_ecommerce/features/product/data/models/product_model.dart';

import 'package:hive/hive.dart';



abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const _boxName = "products_box";

  Future<Box<ProductModel>> _openBox() async {
    return await Hive.openBox<ProductModel>(_boxName);
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final box = await _openBox();
    await box.clear();
    await box.addAll(products);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final box = await _openBox();
    return box.values.toList();
  }
}

