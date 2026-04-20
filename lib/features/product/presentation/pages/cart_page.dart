import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/cart_item.dart';
import '../widgets/cart_list_item.dart';
import '../widgets/total_bar.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart';

  final List<CartItem> cartItems;
  final double totalPrice;
  final ValueChanged<String> onRemoveItem;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : SafeArea(
              top: false,
              child: TotalBar(totalPrice: totalPrice, onCheckout: () {}),
            ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.sm),
              itemCount: cartItems.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartListItem(
                  item: item,
                  onRemove: () => onRemoveItem(item.product.id),
                );
              },
            ),
    );
  }
}
