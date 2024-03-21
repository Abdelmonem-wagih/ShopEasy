
import 'package:shopease/core/exeption/failure.dart';
import 'package:shopease/feature/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProductRepository{
   Future<Either<Failure, List<Product>>> getProduct();
}