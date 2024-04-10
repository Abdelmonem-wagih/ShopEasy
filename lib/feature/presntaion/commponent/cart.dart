import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });


}

class CartCubit extends Cubit<Map<String, CartItem>> {
  CartCubit() : super({});

  void addItem({
    required String productId,
    required double price,
    required String title,
    required String imageUrl,
  }) {
    if (state.containsKey(productId)) {
      // If the product already exists in the cart, update its quantity
      emit({
        ...state,
        productId: CartItem(
          id: productId,
          title: title,
          quantity: state[productId]!.quantity + 1,
          price: price,
          imageUrl: imageUrl,
        ),
      });
    } else {
      // If the product does not exist in the cart, add it
      emit({
        ...state,
        productId: CartItem(
          id: productId,
          title: title,
          quantity: 1,
          price: price,
          imageUrl: imageUrl,
        ),
      });
    }
  }

  void removeItem(String productId) {
    if (state.containsKey(productId)) {
      // Remove the product from the cart
      Map<String, CartItem> updatedCart = Map.from(state);
      updatedCart.remove(productId);
      emit(updatedCart);
    }
  }

  void addSingleItem(String productId) {
    if (state.containsKey(productId)) {
      // Increase the quantity of the product in the cart by 1
      emit({
        ...state,
        productId: CartItem(
          id: productId,
          title: state[productId]!.title,
          quantity: state[productId]!.quantity + 1,
          price: state[productId]!.price,
          imageUrl: state[productId]!.imageUrl,
        ),
      });
    }
  }

  void removeSingleItem(String productId) {
    if (state.containsKey(productId)) {
      if (state[productId]!.quantity > 1) {
        // Decrease the quantity of the product in the cart by 1
        emit({
          ...state,
          productId: CartItem(
            id: productId,
            title: state[productId]!.title,
            quantity: state[productId]!.quantity - 1,
            price: state[productId]!.price,
            imageUrl: state[productId]!.imageUrl,
          ),
        });
      } else {
        // If the quantity is 1, remove the product from the cart
        removeItem(productId);
      }
    }
  }

  void clear() {
    emit({});
  }

  int get itemCount {
    return state.length;
  }

  double get totalAmount {
    double total = 0.0;
    state.forEach((productId, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
