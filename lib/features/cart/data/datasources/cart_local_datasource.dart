import 'dart:convert';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _cartKey = 'cart_items_json_v1';

class CartLocalDataSource {
  final SharedPreferences prefs;
  CartLocalDataSource(this.prefs);

  Future<void> save(List<CartItem> items) async {
    final jsonList = items
        .map((e) => {
              'product': ProductModel(
                id: e.product.id,
                title: e.product.title,
                image: e.product.image,
                description: e.product.description,
                price: e.product.price,
              ).toJson(),
              'quantity': e.quantity,
            })
        .toList();
    await prefs.setString(_cartKey, jsonEncode(jsonList));
  }

  Future<List<CartItem>> load() async {
    final data = prefs.getString(_cartKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded
        .map((e) => CartItem(
              product: ProductModel.fromJson(e['product']),
              quantity: e['quantity'] as int,
            ))
        .toList();
  }
}