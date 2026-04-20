import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/usecases/get_products.dart';
import '../widgets/cart_badge_icon.dart';
import '../widgets/product_grid_item.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  final GetProducts getProducts;
  final int cartCount;
  final VoidCallback onCartTap;
  final ValueChanged<String> onProductTap;
  final ValueChanged<String> onAddFromCard;

  const HomePage({
    super.key,
    required this.getProducts,
    required this.cartCount,
    required this.onCartTap,
    required this.onProductTap,
    required this.onAddFromCard,
  });

  @override
  Widget build(BuildContext context) {
    final products = getProducts();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product Catalog',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: IconButton(
              onPressed: onCartTap,
              icon: CartBadgeIcon(count: cartCount),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.lg,
        ),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.5,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductGridItem(
              product: product,
              onTap: () => onProductTap(product.id),
              onAddToCart: () => onAddFromCard(product.id),
            );
          },
        ),
      ),
    );
  }
}
