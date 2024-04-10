// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/core/helper/notification.dart';
import 'package:shopease/feature/presntaion/commponent/badge.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/feature/presntaion/screens/cart_screen.dart';
import 'feature/presntaion/widget/app_drawer.dart';
import 'feature/presntaion/widget/provider_grid.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    requestPermissions();
    context.read<ProductCubit>().fetchProducts();
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
                      sendFCMNotification();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));

                      context.read<IncreaseBadgeCubit>().incrementBadge();
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
      body: BlocBuilder<ProductCubit, List<QueryDocumentSnapshot>>(
        builder: (context, state) {
          return ProviderGrid(state);
        },
      ),
    );
  }
}
