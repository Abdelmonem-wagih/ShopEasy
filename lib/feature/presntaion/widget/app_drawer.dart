import 'package:flutter/material.dart';

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
          const ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Product"),
          ),
        ],
      ),
    );
  }
}
