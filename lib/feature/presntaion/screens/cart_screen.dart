import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopease/feature/presntaion/commponent/cart.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/order/order_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/payment/payment_cubit.dart';
import 'package:shopease/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyCart"),
      ),
      body: BlocBuilder<CartCubit, Map<String, CartItem>>(
        builder: (context, state) {
          Map<String, CartItem> cartItems = state;

          print('State type: ${state.runtimeType}');

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
                          label: Text(
                            "\$${cart.totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
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
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      String productId = cartItems.keys.elementAt(index);
                      CartItem item = cartItems[productId]!;

                      return Card(
                          color: Colors.grey.shade200,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    width: 110.0,
                                    height: 130,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text('price: ${item.price} \$'),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: ShapeDecoration(
                                            color: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // Optional border
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              cart.addSingleItem(item.id);
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '  Quantity: ${item.quantity}  ',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: ShapeDecoration(
                                            color: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // Optional border
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              cart.removeSingleItem(item.id);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
              ElevatedButton(
                onPressed: () {
                  //_showBottomSheet(context);
                  List<Map<String, CartItem>> items =
                      cartItems.values.map((item) => {'item': item}).toList();
                  if (items.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPaymentMethodDialog(
                          items: items,
                          total: (cart.totalAmount * 100).toStringAsFixed(2),
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        // Handle selected payment method (value)
                        print("Selected payment method: $value");
                      }
                    });
                  }

                  // List<Map<String, CartItem>> items = cartItems.values
                  //     .map((item) => {'item': item})
                  //     .toList();

                  // DateTime now = DateTime.now();
                  // String formattedDate =
                  //     DateFormat('dd/MM/yyyy').format(now);
                  // context.read<OrderCubit>().addOrders(
                  //       items: items,
                  //       payment: 'Cash',
                  //       total: cart.totalAmount.toStringAsFixed(2),
                  //       date: formattedDate,
                  //     );
                },
                child: const Text('CheckOut'),
              )
            ],
          );
        },
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );

class CustomPaymentMethodDialog extends StatelessWidget {
  final String total;
  final List<Map<String, CartItem>> items;

  const CustomPaymentMethodDialog({
    super.key,
    required this.total,
    required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Payment ",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            const Text(
              "Choose which payment method?",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
                    context.read<OrderCubit>().addOrders(
                          items: items,
                          payment: 'Cash',
                          total: total,
                          date: formattedDate,
                        );
                    Navigator.of(context).pop("Cash");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    child: Text("Cash"),
                  ),
                ),
                BlocProvider(
                  create: (context) => PaymentCubit()..getAuthToken(),
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) {
                      if (state is PaymentRequestTokenLoadingStates) {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PaymentRequestTokenSuccessStates) {
                        navigateTo(context, VisaScreen());
                      }
                    },
                    builder: (context, state) {
                      var cubit = PaymentCubit.get(context);

                      return ElevatedButton(
                        onPressed: () {
                          cubit.getOrderRegistrationID(
                            price: total,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 12.0),
                          child: Text("Visa"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Choose which payment method?",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop("Cash");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Cash",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop("Visa");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Visa",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      // Handle selected payment method (value)
      print("Selected payment method: $value");
    }
  });
}
