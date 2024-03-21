import 'package:flutter/material.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductsItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
   // final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
               
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                 
                } catch (error) {
                  // scaffold.showSnackBar(
                  //   SnackBar(
                  //     content: Text(
                  //       "Deleting fialed!",
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                //  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
