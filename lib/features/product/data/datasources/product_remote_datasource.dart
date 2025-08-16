import 'package:dio/dio.dart';
import 'package:mini_ecommerce/core/constants/api_endpoints.dart';
import 'package:mini_ecommerce/core/utils/app_exception.dart';
import 'package:mini_ecommerce/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final resp = await dio.get(ApiEndpoints.products);
      if (resp.statusCode == 200) {
        final list = (resp.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return list;
      }
      throw const ServerException();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}