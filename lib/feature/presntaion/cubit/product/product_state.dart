part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;

  const ProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductFailure extends ProductState {
  final String productFailure;

  const ProductFailure({required this.productFailure});
  @override
  List<Object> get props => [productFailure];
}
