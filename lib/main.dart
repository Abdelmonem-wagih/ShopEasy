import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shopease/core/helper/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/core/network/dio.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/order/order_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/firebase_options.dart';
import 'package:shopease/home_screen.dart';

import 'feature/presntaion/commponent/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await DioHelperPayment.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('///////////////////////////////////////////////////////////');
        print(message.notification!.title);
        print(message.notification!.body);
        print('///////////////////////////////////////////////////////////');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (context) => di.sl<ProductCubit>()..fetchProducts(),
        ),
        BlocProvider<OrderCubit>(
          create: (context) => di.sl<OrderCubit>()..fetchOrders(),
        ),
        BlocProvider<IncreaseBadgeCubit>(
          create: (context) => di.sl<IncreaseBadgeCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => di.sl<CartCubit>(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => di.sl<ProductCubit>()..fetchProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
