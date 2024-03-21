import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:shopease/feature/domain/entities/product.dart";

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.category!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 300,
                height: 300,
                child: Image.network(
                  product.image!,
                  fit: BoxFit.contain,
                  
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 15),
              child: Text(
                product.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 15),
              child: Text(
                "\$${product.price}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              endIndent: 20,
              indent: 20,
              thickness: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15),
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.description!,
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
