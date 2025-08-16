import 'package:mini_ecommerce/features/product/domain/entities/product.dart';
import 'package:mini_ecommerce/features/product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<List<Product>> call() => repository.getProducts();
}