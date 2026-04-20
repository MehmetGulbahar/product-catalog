import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/product/data/datasources/product_mock_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/entities/cart_item.dart';
import 'features/product/domain/usecases/get_product_detail.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/presentation/pages/cart_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/product_detail_arguments.dart';
import 'features/product/presentation/pages/product_detail_page.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatefulWidget {
  const MiniCatalogApp({super.key});

  @override
  State<MiniCatalogApp> createState() => _MiniCatalogAppState();
}

class _MiniCatalogAppState extends State<MiniCatalogApp> {
  late final GetProducts _getProducts;
  late final GetProductDetail _getProductDetail;

  final List<CartItem> _cartItems = [];

  int get _cartCount {
    return _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  double get _totalPrice {
    return _cartItems.fold<double>(0, (sum, item) => sum + item.lineTotal);
  }

  @override
  void initState() {
    super.initState();
    final dataSource = ProductMockDataSource();
    final repository = ProductRepositoryImpl(dataSource);

    _getProducts = GetProducts(repository);
    _getProductDetail = GetProductDetail(repository);
  }

  void _addToCart(String productId, int quantity) {
    final product = _getProductDetail(productId);
    if (product == null) {
      return;
    }

    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.product.id == productId,
      );

      if (index == -1) {
        _cartItems.add(CartItem(product: product, quantity: quantity));
      } else {
        final existing = _cartItems[index];
        _cartItems[index] = existing.copyWith(
          quantity: existing.quantity + quantity,
        );
      }
    });
  }

  void _removeFromCart(String productId) {
    setState(() {
      _cartItems.removeWhere((item) => item.product.id == productId);
    });
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute<void>(
          builder: (context) {
            return HomePage(
              getProducts: _getProducts,
              cartCount: _cartCount,
              onCartTap: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
              onProductTap: (productId) {
                Navigator.of(context).pushNamed(
                  ProductDetailPage.routeName,
                  arguments: ProductDetailArguments(productId: productId),
                );
              },
              onAddFromCard: (productId) {
                _addToCart(productId, 1);
              },
            );
          },
          settings: settings,
        );
      case ProductDetailPage.routeName:
        final args = settings.arguments as ProductDetailArguments;
        return MaterialPageRoute<void>(
          builder: (_) {
            return ProductDetailPage(
              productId: args.productId,
              getProductDetail: _getProductDetail,
              onAddToCart: _addToCart,
            );
          },
          settings: settings,
        );
      case CartPage.routeName:
        return MaterialPageRoute<void>(
          builder: (_) {
            return CartPage(
              cartItems: _cartItems,
              totalPrice: _totalPrice,
              onRemoveItem: _removeFromCart,
            );
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: HomePage.routeName,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
