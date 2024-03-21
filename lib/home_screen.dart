// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/commponent/badge.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/screens/cart_screen.dart';

import 'feature/presntaion/widget/app_drawer.dart';
import 'feature/presntaion/widget/provider_grid.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShopEase"),
        actions: [
          Center(
            child: BlocBuilder<IncreaseBadgeCubit, int>(
              builder: (context, state) {
                return BadgeWidget(
                  value: state,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CartScreen() ,));
                      //
                     // context.read<IncreaseBadgeCubit>().incrementBadge();
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                );
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selecteValue) {},
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text("Only Favorite "),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Show All "),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return ProviderGrid(state.product);
          } else {
            return const Center(
              child: Text('Same thing is wrong'),
            );
          }
        },
      ),
    );
  }
}
