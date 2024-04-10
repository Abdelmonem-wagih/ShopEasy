import 'package:flutter/material.dart';
import 'package:shopease/feature/presntaion/screens/manage_product_screen.dart';
import 'package:shopease/feature/presntaion/screens/orders.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello Friend !"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          const Divider(),
           ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    ),
                    (route) => false,
                  )
            //OrderScreen
          ),
          const Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Product"),
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ManageProductScreen(),
                    ),
                    (route) => false,
                  )
              ),
        ],
      ),
    );
  }
}
