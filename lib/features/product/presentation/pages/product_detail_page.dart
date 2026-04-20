import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_detail.dart';
import '../widgets/price_text.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/section_title.dart';

class ProductDetailPage extends StatefulWidget {
  static const String routeName = '/product-detail';

  final String productId;
  final GetProductDetail getProductDetail;
  final void Function(String productId, int quantity) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.getProductDetail,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void _decreaseQuantity() {
    if (_quantity <= 1) {
      return;
    }

    setState(() {
      _quantity -= 1;
    });
  }

  void _increaseQuantity() {
    setState(() {
      _quantity += 1;
    });
  }

  void _addToCart() {
    widget.onAddToCart(widget.productId, _quantity);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Added $_quantity item(s) to cart')));
  }

  @override
  Widget build(BuildContext context) {
    final Product? product = widget.getProductDetail(widget.productId);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSurfaceCard(
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Container(
                        color: AppColors.lightGray,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionTitle(
              title: product.title,
              subtitle: 'Simple, clean and reliable product details.',
            ),
            const SizedBox(height: AppSpacing.xs),
            PriceText(price: product.price, fontSize: 22),
            const SizedBox(height: AppSpacing.sm),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                QuantitySelector(
                  quantity: _quantity,
                  onDecrease: _decreaseQuantity,
                  onIncrease: _increaseQuantity,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.sm),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentBlue,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              elevation: 0,
            ),
            child: const Text('Add To Cart'),
          ),
        ),
      ),
    );
  }
}
