import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../domain/entities/cart_item.dart';
import '../widgets/cart_list_item.dart';
import '../widgets/section_title.dart';
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
          ? const EmptyStateView(
              icon: Icons.shopping_bag_outlined,
              title: 'Your cart is empty',
              subtitle: 'Add products from the catalog to continue.',
            )
          : ListView.separated(
              padding: AppSpacing.pagePadding,
              itemCount: cartItems.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SectionTitle(
                    title: 'Cart Items',
                    subtitle: 'Review your selected products.',
                  );
                }

                final item = cartItems[index - 1];
                return CartListItem(
                  item: item,
                  onRemove: () => onRemoveItem(item.product.id),
                );
              },
            ),
    );
  }
}
