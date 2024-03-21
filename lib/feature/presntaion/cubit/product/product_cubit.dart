import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopease/core/usecase/base_usecase.dart';
import 'package:shopease/feature/domain/entities/product.dart';
import 'package:shopease/feature/domain/usecase/get_product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;
  ProductCubit(this.getProductUseCase) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductInitial());
    final response = await getProductUseCase(const NoParameters());
    

    response.fold(
      (failure) => emit(
        const ProductFailure(
          productFailure: 'can not fetch Product Data',
        ),
      ),
      (product) {
        emit(
          ProductLoaded(product: product),
        );
      },
    );
  }
}
