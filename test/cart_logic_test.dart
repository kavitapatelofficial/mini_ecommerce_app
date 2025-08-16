import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mini_ecommerce/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  late CartLocalDataSource dataSource;

  setUp(() async {
    // Initialize in-memory SharedPreferences
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dataSource = CartLocalDataSource(prefs);
  });

  final testProduct = ProductModel(
    id: 1,
    title: 'Test Product',
    image: 'image.png',
    description: 'A product for testing',
    price: 99.99,
  );

  final testCartItem = CartItem(product: testProduct, quantity: 2);

  group('CartLocalDataSource', () {
    test('save stores cart items in SharedPreferences', () async {
      await dataSource.save([testCartItem]);

      final stored = prefs.getString('cart_items_json_v1');
      expect(stored, isNotNull);

      final decoded = jsonDecode(stored!) as List;
      expect(decoded.length, 1);
      expect(decoded[0]['quantity'], 2);
      expect(decoded[0]['product']['id'], testProduct.id);
    });

    test('load retrieves cart items from SharedPreferences', () async {
      // Save manually to prefs first
      final jsonList = [
        {
          'product': testProduct.toJson(),
          'quantity': 2,
        }
      ];
      await prefs.setString('cart_items_json_v1', jsonEncode(jsonList));

      final items = await dataSource.load();
      expect(items.length, 1);
      expect(items.first.quantity, 2);
      expect(items.first.product.id, testProduct.id);
      expect(items.first.product.title, testProduct.title);
    });

    test('load returns empty list if no data', () async {
      final items = await dataSource.load();
      expect(items, isEmpty);
    });
  });
}
