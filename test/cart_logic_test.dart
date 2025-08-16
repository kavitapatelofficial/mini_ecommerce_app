import 'package:flutter_test/flutter_test.dart';
import 'package:mini_ecommerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

class _FakeLocal { Future<void> save(List<CartItem> _) async {} Future<List<CartItem>> load() async => []; }

void main() {
  test('add and update qty works', () {
    final repo = CartRepositoryImpl(_FakeLocal() as dynamic);

    final p = const Product(id: 1, title: 'A', image: '', description: '', price: 10.0);
    var list = <CartItem>[];

    list = repo.add(list, p);
    expect(list.single.quantity, 1);

    list = repo.add(list, p);
    expect(list.single.quantity, 2);

    list = repo.updateQty(list, p, 5);
    expect(list.single.quantity, 5);

    list = repo.updateQty(list, p, 0); // remove
    expect(list.isEmpty, true);
  });
}