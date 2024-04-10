// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/screens/manage_product_screen.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key, required this.id, required this.product});
  
  final String id;
  final QueryDocumentSnapshot product;
  final _form = GlobalKey<FormState>();

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = product['title'];
    priceController.text = product['price'];
    descriptionController.text = product['description'];
    imageUrlController.text = product['image'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: priceController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a Price";
                }
                if (double.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                if (double.parse(value) <= 0) {
                  return "Please enter a number greater than Zero";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                hoverColor: Colors.green,
                focusColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              controller: descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a description";
                }
                if (value.length < 10) {
                  return "Should be at least 10 characters long.";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Image URL',
                hoverColor: Colors.green,
                focusColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              controller: imageUrlController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a Image URl";
                }
                if (!value.startsWith("https") && !value.startsWith("http")) {
                  return "Please enter a valid URL";
                }
                if (!value.endsWith(".jpg") &&
                    !value.endsWith(".png") &&
                    !value.endsWith(".jpeg")) {
                  return "Please enter a valid image URL";
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  context.read<ProductCubit>().editProducts(
                        id: id,
                        titleController: titleController.text,
                        descriptionController: descriptionController.text,
                        priceController: priceController.text,
                        imageUrlController: imageUrlController.text,
                      );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const ManageProductScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
