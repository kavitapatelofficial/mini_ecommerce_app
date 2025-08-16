import 'package:flutter_test/flutter_test.dart';
import 'package:mini_ecommerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';
import 'package:shared_preferences/src/shared_preferences_legacy.dart';

// Fake datasource implementing the interface
class FakeCartLocalDataSource implements CartLocalDataSource {
  @override
  Future<void> save(List<CartItem> items) async {}

  @override
  Future<List<CartItem>> load() async => [];

  @override
  // TODO: implement prefs
  SharedPreferences get prefs => throw UnimplementedError();
}

void main() {
  test('calculates total price correctly', () {
    final repo = CartRepositoryImpl(FakeCartLocalDataSource());

    final items = [
      CartItem(
          product: const Product(id: 1, title: 'A', image: '', description: '', price: 100.0),
          quantity: 2),
      CartItem(
          product: const Product(id: 2, title: 'B', image: '', description: '', price: 59.99),
          quantity: 1),
    ];

    final total = repo.total(items);

    expect(total, 259.99);
  });
}
