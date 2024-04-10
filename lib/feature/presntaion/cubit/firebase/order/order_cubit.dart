import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopease/feature/presntaion/commponent/cart.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<List<Map<String, dynamic>>> {
  OrderCubit() : super([]);

  CollectionReference orders = FirebaseFirestore.instance.collection('Orders');

  Future<void> fetchOrders() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await orders.get() as QuerySnapshot<Map<String, dynamic>>;

      final List<Map<String, dynamic>> ordersList = [];

      querySnapshot.docs.forEach((doc) {
        ordersList.add({
          'orderId': doc.id,
          'items': doc.data()['items'],
          'payment': doc.data()['payment'],
          'total': doc.data()['total'],
          'date': doc.data()['date'],
          
        });
      });

      emit(ordersList);
    } catch (e) {
      print('Failed to fetch orders: $e');
    }
  }

  Future<void> addOrders({
    required List<Map<String, CartItem>> items,
    required String payment,
    required String total,
    required String date,
  }) async {
    try {
      // Convert each CartItem object into a map representation
      List<Map<String, dynamic>> itemsList = items.map((item) {
        return {
          'id': item['item']!.id,
          'title': item['item']!.title,
          'quantity': item['item']!.quantity,
          'price': item['item']!.price,
          'imageUrl': item['item']!.imageUrl,
        };
      }).toList();

      // Convert the list into a JSON string
      String jsonString = json.encode(itemsList);

      // Store the JSON string in Firebase
      await orders.doc().set({
        'payment': payment,
        'total': total,
        'date': date,
        'items': jsonString,
      });
    } catch (e) {
      print('Failed to add Product $e');
    }
  }
}
