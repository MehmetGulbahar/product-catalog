import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository _repository;

  const GetProducts(this._repository);

  List<Product> call() {
    return _repository.getProducts();
  }
}
