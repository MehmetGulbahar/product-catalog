import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_mock_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductMockDataSource _dataSource;

  const ProductRepositoryImpl(this._dataSource);

  @override
  List<Product> getProducts() {
    return _dataSource.getProducts();
  }

  @override
  Product? getProductDetail(String productId) {
    final products = _dataSource.getProducts();

    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (_) {
      return null;
    }
  }
}
