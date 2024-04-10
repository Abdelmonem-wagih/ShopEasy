import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/feature/presntaion/cubit/firebase/product/product_cubit.dart';
import 'package:shopease/feature/presntaion/screens/add_product_screen.dart';
import 'package:shopease/feature/presntaion/screens/edit_product_screen.dart';
import 'package:shopease/feature/presntaion/widget/app_drawer.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ProductCubit, List<QueryDocumentSnapshot>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final product = state[index];
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(product.id),
                background: Container(
                  color: Theme.of(context).errorColor,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                confirmDismiss: (direction) {
                  
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text("Are you Sure ?"),
                      content: const Text(
                          "Do you want to remove the item from the cart ?"),
                      actions: [
                        TextButton(
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text("Yes"),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  context.read<ProductCubit>().deleteProduct(product.id);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product['image']),
                      radius: 30,
                    ),
                    title: Text(
                      product['title'],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text('${product['price']} \$'),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              id: product.id,
                              product: product,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
