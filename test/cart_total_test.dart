import 'package:flutter_test/flutter_test.dart';
import 'package:mini_ecommerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

class _FakeLocal { Future<void> save(List<CartItem> _) async {} Future<List<CartItem>> load() async => []; }

void main() {
  test('calculates total price correctly', () {
    final repo = CartRepositoryImpl(/* ignore: invalid_use_of_internal_member */ // not used in test
        // provide a fake local
        // ignore: unnecessary_new
        new _FakeLocal() as dynamic);

    final items = [
      CartItem(product: const Product(id: 1, title: 'A', image: '', description: '', price: 100.0), quantity: 2),
      CartItem(product: const Product(id: 2, title: 'B', image: '', description: '', price: 59.99), quantity: 1),
    ];

    final total = repo.total(items);
    expect(total, 259.99);
  });
}