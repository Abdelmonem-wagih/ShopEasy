import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'proudect_item.dart';

class ProviderGrid extends StatelessWidget {
  final List<QueryDocumentSnapshot> product;
  const ProviderGrid(this.product, {super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: product.length,
      itemBuilder: (ctx, index) {
        final productItem = product[index];
        return ProductItem(product: productItem,);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 250,
      ),
    );
  }
}
