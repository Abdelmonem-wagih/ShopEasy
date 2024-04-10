import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopease/feature/presntaion/cubit/expend/expend_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/order/order_cubit.dart';
import 'package:shopease/feature/presntaion/widget/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().fetchOrders();
    return Scaffold( 
      appBar: AppBar(
        title:const Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<OrderCubit, List<Map<String, dynamic>>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final order = state[index];
              final items = order['items'];

              // Decode the items string to JSON if it's a string
              final decodedItems = jsonDecode(items) as List<dynamic>;
              // Cast the items to List<Map<String, dynamic>>
              final itemList = decodedItems.cast<Map<String, dynamic>>();
              // Now, itemList should be a list of maps
              return _buildOrder(itemList, order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrder(
      List<Map<String, dynamic>> items, Map<String, dynamic> order) {
  
                      

    return BlocProvider<ExpendCubit>(
      create: (context) => ExpendCubit(),
      child: BlocBuilder<ExpendCubit, bool>(
        builder: (context, state) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text('${order['total']} (${order['payment']})'),
                  subtitle: Text(order['date']),
                  trailing: IconButton(
                    icon: Icon(state ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      context.read<ExpendCubit>().toggleFavorite();
                    },
                  ),
                ),
                if (state)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    height: min(items.length * 30.0 + 10, 100),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${item['quantity']} x \$${item['price']} ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}



/**
 */