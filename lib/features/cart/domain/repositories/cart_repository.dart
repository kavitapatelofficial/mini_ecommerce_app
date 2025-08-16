import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

abstract class CartRepository {
  Future<List<CartItem>> loadCart();
  Future<void> saveCart(List<CartItem> items);
  List<CartItem> add(List<CartItem> items, Product product);
  List<CartItem> remove(List<CartItem> items, Product product);
  List<CartItem> updateQty(List<CartItem> items, Product product, int qty);
  double total(List<CartItem> items);
}