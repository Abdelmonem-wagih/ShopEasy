import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<List<QueryDocumentSnapshot>> {
  ProductCubit() : super([]);

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> fetchProducts() async {
    try {
      final querySnapshot = await products.get();
      emit(querySnapshot.docs);
    } catch (e) {
      // Handle error if needed
      print('Error fetching products: $e');
    }
  }

  Future<void> addProducts({
    required String titleController,
    required String descriptionController,
    required String priceController,
    required String imageUrlController,
  }) async {
    try {
      await products.add({
        'title': titleController,
        'description': descriptionController,
        'price': priceController,
        'image': imageUrlController,
      });
    } catch (e) {
      print('Failed to add Product $e');
    }
  }

  Future<void> editProducts({
    required String id,
    required String titleController,
    required String descriptionController,
    required String priceController,
    required String imageUrlController,
  }) async {
    try {
      await products.doc(id).update({
        'title': titleController,
        'description': descriptionController,
        'price': priceController,
        'image': imageUrlController,
      });
    } catch (e) {
      print('Failed to add Product $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await products.doc(productId).delete();

      emit(state.where((doc) => doc.id != productId).toList());
    } catch (e) {
      // Handle error if needed
      print('Error deleting product: $e');
    }
  }
}
