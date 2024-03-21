import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/commponent/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MyCart"),
      ),
      body: BlocProvider(
        create: (context) => CartCubit(),
        child: BlocBuilder<CartCubit, List<CartItem>>(
          builder: (context, state) {
            return Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontSize: 20),
                        ),
                        const Spacer(),
                        FittedBox(
                          child: Chip(
                            label:  Text(
                              "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                              style:const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        //OrderButton(cart: cart)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state[index].title),
                      subtitle: Text('Quantity: ${state[index].quantity}'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add an item to the cart when the button is pressed
                    context.read<CartCubit>().addItem(
                          'productId',
                          10.0, // Price
                          'Product Title',
                        );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// class OrderButton extends StatefulWidget {
//   const OrderButton({
//     Key key,
//     @required this.cart,
//   }) : super(key: key);

//   final Cart cart;

//   @override
//   _OrderButtonState createState() => _OrderButtonState();
// }

// class _OrderButtonState extends State<OrderButton> {
//   var _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       child: _isLoading
//           ? CircularProgressIndicator()
//           : Text(
//               "ORDER NOW",
//               style: TextStyle(
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//       onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
//           ? null
//           : () async {
//               setState(() {
//                 _isLoading = true;
//               });
//               await Provider.of<Orders>(context, listen: false).addOrder(
//                 widget.cart.items.values.toList(),
//                 widget.cart.totalAmount,
//               );
//               setState(() {
//                 _isLoading = false;
//               });
//               widget.cart.clear();
//             },
//     );
//   }
// }
