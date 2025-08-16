import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_ecommerce/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:mini_ecommerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _prefsProvider = FutureProvider<SharedPreferences>((_) => SharedPreferences.getInstance());
final _cartRepoProvider = FutureProvider<CartRepositoryImpl>((ref) async {
  final prefs = await ref.watch(_prefsProvider.future);
  return CartRepositoryImpl(CartLocalDataSource(prefs));
});

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  CartRepositoryImpl? _repo;

  @override
  Future<List<CartItem>> build() async {
    _repo = await ref.watch(_cartRepoProvider.future);
    final items = await _repo!.loadCart();
    return items;
  }

  Future<void> _persist(List<CartItem> items) async {
    await _repo!.saveCart(items);
    state = AsyncData(items);
  }

  void add(Product product) {
    final items = _repo!.add(state.value ?? [], product);
    _persist(items);
  }

  void remove(Product product) {
    final items = _repo!.remove(state.value ?? [], product);
    _persist(items);
  }

  void updateQty(Product product, int qty) {
    final items = _repo!.updateQty(state.value ?? [], product, qty);
    _persist(items);
  }

  double get total => _repo!.total(state.value ?? []);
}

final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItem>>(() => CartNotifier());
final cartCountProvider = Provider<int>((ref) => (ref.watch(cartProvider).value ?? []).fold(0, (p, e) => p + e.quantity));
