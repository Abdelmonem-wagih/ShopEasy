import 'package:flutter/material.dart';
import 'package:shopease/core/helper/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/product/product_cubit.dart';
import 'package:shopease/home_screen.dart';

import 'feature/presntaion/commponent/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (context) => di.sl<ProductCubit>()..fetchProducts(),
        ),
        BlocProvider<IncreaseBadgeCubit>(
          create: (context) => di.sl<IncreaseBadgeCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => di.sl<CartCubit>(),
        ),
        //
        // BlocProvider<FavoriteCubit>(
        //   create: (context) => di.sl<FavoriteCubit>(),
        // ),
      ],
      child: MaterialApp(
        title: 'ShopEase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductsOverviewScreen(),
      ),
    );
  }
}


      // builder: (context, state) {
      //   return MaterialApp(
      //       title: 'ShopEase',
      //       theme: ThemeData(
      //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //         useMaterial3: true,
      //       ),
      //       home: const ProductsOverviewScreen());
      // },
