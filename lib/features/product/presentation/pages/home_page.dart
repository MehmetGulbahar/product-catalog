import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/loading_state_view.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../widgets/cart_badge_icon.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class HomePage extends StatefulWidget {
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  String? _errorMessage;
  String _query = '';
  List<Product> _products = const [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 700));

    try {
      final products = widget.getProducts();
      if (!mounted) {
        return;
      }

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = 'Products could not be loaded. Please try again.';
      });
    }
  }

  List<Product> get _filteredProducts {
    final keyword = _query.trim().toLowerCase();
    if (keyword.isEmpty) {
      return _products;
    }

    return _products.where((product) {
      return product.title.toLowerCase().contains(keyword) ||
          product.description.toLowerCase().contains(keyword);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: IconButton(
              onPressed: widget.onCartTap,
              icon: CartBadgeIcon(count: widget.cartCount),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Our Products',
              subtitle: 'Discover simple and quality office essentials.',
            ),
            const SizedBox(height: AppSpacing.sm),
            _SearchBar(
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const LoadingStateView();
    }

    if (_errorMessage != null) {
      return ErrorStateView(message: _errorMessage!);
    }

    final filteredProducts = _filteredProducts;
    if (filteredProducts.isEmpty) {
      return EmptyStateView(
        icon: Icons.search_off,
        title: _query.isEmpty
            ? 'No products available'
            : 'No matching products',
        subtitle: _query.isEmpty
            ? 'New items will appear here when available.'
            : 'Try a different keyword.',
      );
    }

    return GridView.builder(
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return ProductCard(
          product: product,
          onTap: () => widget.onProductTap(product.id),
          onAddToCart: () => widget.onAddFromCard(product.id),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search products...',
      ),
    );
  }
}
