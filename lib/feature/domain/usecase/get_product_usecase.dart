import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopease/core/exeption/failure.dart';
import 'package:shopease/core/usecase/base_usecase.dart';
import 'package:shopease/feature/domain/entities/product.dart';
import 'package:shopease/feature/domain/repository/base_product_repository.dart';

class GetProductUseCase extends BaseUseCase<List<Product>, NoParameters> {
  final BaseProductRepository baseProductRepository;

  GetProductUseCase({required this.baseProductRepository});
  @override
  Future<Either<Failure, List<Product>>> call(
      NoParameters parameters) async {
    return await baseProductRepository.getProduct();
  }
}

class ProductParameter extends Equatable {
  final int productId;

  const ProductParameter({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];
}
