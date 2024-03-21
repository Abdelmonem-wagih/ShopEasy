import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addItem(String productId, double price, String title) {
    final cartItemIndex =
        state.indexWhere((item) => item.id == productId);

    if (cartItemIndex >= 0) {
      final List<CartItem> updatedCart = List.from(state);
      updatedCart[cartItemIndex] = CartItem(
        id: state[cartItemIndex].id,
        title: state[cartItemIndex].title,
        quantity: state[cartItemIndex].quantity + 1,
        price: state[cartItemIndex].price,
      );
      emit(updatedCart);
    } else {
      final List<CartItem> updatedCart = List.from(state);
      updatedCart.add(
        CartItem(
          id: productId,
          title: title,
          quantity: 1,
          price: price,
        ),
      );
      emit(updatedCart);
    }
  }

  void removeItem(String productId) {
    final List<CartItem> updatedCart =
        List.from(state.where((item) => item.id != productId));
    emit(updatedCart);
  }

  void removeSingleItem(String productId) {
    final cartItemIndex =
        state.indexWhere((item) => item.id == productId);

    if (cartItemIndex >= 0 && state[cartItemIndex].quantity > 1) {
      final List<CartItem> updatedCart = List.from(state);
      updatedCart[cartItemIndex] = CartItem(
        id: state[cartItemIndex].id,
        title: state[cartItemIndex].title,
        quantity: state[cartItemIndex].quantity - 1,
        price: state[cartItemIndex].price,
      );
      emit(updatedCart);
    } else {
      removeItem(productId);
    }
  }

  void clear() {
    emit([]);
  }

  int get itemCount {
    return state.length;
  }

  double get totalAmount {
    var total = 0.0;
    state.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
