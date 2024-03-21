import 'package:dartz/dartz.dart';
import 'package:shopease/core/exeption/exception.dart';
import 'package:shopease/core/exeption/failure.dart';
import 'package:shopease/feature/data/data_source/remote_data_source.dart';
import 'package:shopease/feature/domain/entities/product.dart';
import 'package:shopease/feature/domain/repository/base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  ProductRepository({required this.baseRemoteDataSource});
  @override
  Future<Either<Failure, List<Product>>> getProduct(
      ) async {
    final result = await baseRemoteDataSource.getProduct();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
