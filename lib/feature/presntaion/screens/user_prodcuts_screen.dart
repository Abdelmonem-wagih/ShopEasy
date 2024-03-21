import 'package:flutter/material.dart';
import 'package:shopease/feature/presntaion/widget/app_drawer.dart';

import 'user_products_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routName = "/user-products";

  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products "),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, i) => const Column(
            children: [
              UserProductsItem('1', 'shop', 'men and women'),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
