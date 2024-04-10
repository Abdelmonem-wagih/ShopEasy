import 'package:flutter/material.dart';
import 'package:shopease/feature/presntaion/widget/form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: MyForm(),
    );
  }
}
