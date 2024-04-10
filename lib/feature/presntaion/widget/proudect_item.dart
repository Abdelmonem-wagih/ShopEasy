import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/commponent/cart.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final QueryDocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${product['price']!}'),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  context.read<IncreaseBadgeCubit>().incrementBadge();
                  context.read<CartCubit>().addItem(
                        price: double.parse(product['price']),
                        title: product['title'],
                        productId: product.id,
                        imageUrl: product['image'],
                      );
                },
                color: Colors.white70,
              ),
            ],
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product['title'],
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          product['image'],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
