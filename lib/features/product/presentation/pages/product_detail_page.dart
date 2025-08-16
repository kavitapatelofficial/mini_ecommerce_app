import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'p_${product.id}',
              child: product.localImagePath != null
                  ? Image.file(
                      File(product.localImagePath!),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      product.image,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₹${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(tr('description'),
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(product.description),
                const SizedBox(height: 16),
                cartState.when(
                  data: (items) {
                    final cartItem = items.firstWhere(
                      (e) => e.product.id == product.id,
                      orElse: () => CartItem(product: product, quantity: 0),
                    );

                    if (cartItem.quantity > 0) {
                      // Already in cart → Show + / - buttons
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (cartItem.quantity > 1) {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateQty(product, cartItem.quantity - 1);
                              } else {
                                ref.read(cartProvider.notifier).remove(product);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            "${cartItem.quantity}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .updateQty(product, cartItem.quantity + 1);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ).animate().scale(duration: 250.ms);
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ref.read(cartProvider.notifier).add(product);
                            },
                            label: const Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(126, 35),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ).animate().scale(duration: 250.ms),
                        ),
                      );
                    }
                  },
                  loading: () => const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator()),
                  error: (e, st) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Error: $e"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
