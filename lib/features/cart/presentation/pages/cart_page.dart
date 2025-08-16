import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:mini_ecommerce/features/cart/presentation/widgets/cart_item_tile.dart';

class CartPage extends ConsumerWidget {
  static const route = '/cart';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(title: Text(tr('cart'))),
      body: asyncCart.when(
        data: (items) => items.isEmpty
            ? Center(child: Text(tr('empty_cart')))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      itemBuilder: (_, i) => CartItemTile(
                        item: items[i],
                        onRemove: () => ref.read(cartProvider.notifier).remove(items[i].product),
                        onQtyChanged: (q) => ref.read(cartProvider.notifier).updateQty(items[i].product, q),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${tr('total')}: ₹${ref.read(cartProvider.notifier).total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        FilledButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Checkout not implemented')),
                          ),
                          child: const Text('Checkout'),
                        )
                      ],
                    ),
                  )
                ],
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
