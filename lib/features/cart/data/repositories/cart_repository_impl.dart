import 'package:mini_ecommerce/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;
  CartRepositoryImpl(this.local);

  @override
  Future<List<CartItem>> loadCart() => local.load();

  @override
  Future<void> saveCart(List<CartItem> items) => local.save(items);

  @override
  List<CartItem> add(List<CartItem> items, Product product) {
    final idx = items.indexWhere((e) => e.product.id == product.id);
    if (idx == -1) {
      return [...items, CartItem(product: product, quantity: 1)];
    }
    final updated = [...items];
    updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + 1);
    return updated;
  }

  @override
  List<CartItem> remove(List<CartItem> items, Product product) {
    return items.where((e) => e.product.id != product.id).toList();
  }

  @override
  List<CartItem> updateQty(List<CartItem> items, Product product, int qty) {
    final idx = items.indexWhere((e) => e.product.id == product.id);
    if (idx == -1) return items;
    final updated = [...items];
    if (qty <= 0) {
      updated.removeAt(idx);
    } else {
      updated[idx] = updated[idx].copyWith(quantity: qty);
    }
    return updated;
  }

  @override
  double total(List<CartItem> items) {
    return items.fold(0.0, (sum, e) => sum + e.product.price * e.quantity);
  }
}
