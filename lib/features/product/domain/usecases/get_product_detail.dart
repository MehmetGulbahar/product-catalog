import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository _repository;

  const GetProductDetail(this._repository);

  Product? call(String productId) {
    return _repository.getProductDetail(productId);
  }
}
