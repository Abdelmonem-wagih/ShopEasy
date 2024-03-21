import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/domain/entities/product.dart';
import 'package:shopease/feature/presntaion/cubit/favorite/favorite_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/feature/presntaion/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${product.price!}'),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  context.read<IncreaseBadgeCubit>().incrementBadge();
                },
                color: Colors.white70,
              ),
            ],
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.category!,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          )),
          child: Image.network(
            product.image!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
