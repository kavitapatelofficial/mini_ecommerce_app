import 'package:flutter/material.dart';
import 'package:mini_ecommerce/features/cart/domain/entities/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQtyChanged;
  const CartItemTile({super.key, required this.item, required this.onRemove, required this.onQtyChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Image.network(item.product.image, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('₹${item.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: () => onQtyChanged(item.quantity - 1), icon: const Icon(Icons.remove_circle_outline)),
                Text('${item.quantity}'),
                IconButton(onPressed: () => onQtyChanged(item.quantity + 1), icon: const Icon(Icons.add_circle_outline)),
              ],
            ),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.delete_outline))
          ],
        ),
      ),
    );
  }
}
