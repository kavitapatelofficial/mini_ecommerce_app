import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:mini_ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';
import 'package:mini_ecommerce/features/product/presentation/pages/product_detail_page.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'p_${product.id}',
                child: product.localImagePath != null
                    ? Image.file(
                        File(product.localImagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),

            /// Cart Condition UI
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
                  // Not in cart → Show Add to Cart button
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref.read(cartProvider.notifier).add(product);
                        onAdd();
                      },
                      // icon: const Icon(Icons.add_shopping_cart, size: 18), // icon size chhota
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 12), // text size chhota
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size(126, 35), // width = 120, height = 35
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4), // andar ka padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // rounded corners
                        ),
                      ),
                    ).animate().scale(duration: 250.ms),
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
      ),
    );
  }
}
