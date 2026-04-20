import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      product: product,
      onTap: onTap,
      onAddToCart: onAddToCart,
    );
  }
}
