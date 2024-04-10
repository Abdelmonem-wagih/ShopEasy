import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/screens/manage_product_screen.dart';

class MyForm extends StatelessWidget {
  MyForm({
    super.key,
  });
  final _form = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            controller: _titleController,
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
            controller: _priceController,
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
            onSaved: (value) {},
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
            controller: _descriptionController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a description";
              }
              if (value.length < 10) {
                return "Should be at least 10 characters long.";
              }
              return null;
            },
            onSaved: (value) {},
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
            controller: _imageUrlController,
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
            onSaved: (value) {},
          ),
          const SizedBox(height: 25),
          TextButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                context.read<ProductCubit>().addProducts(
                      titleController: _titleController.text,
                      descriptionController: _descriptionController.text,
                      priceController: _priceController.text,
                      imageUrlController: _imageUrlController.text,
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
                  'Add',
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
    );
  }
}
