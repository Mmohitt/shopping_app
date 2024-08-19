import 'package:e_comm_app/models/product.dart';
import 'package:e_comm_app/screens/product_details.dart';
import 'package:e_comm_app/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen(
      {super.key,
        this.title,
        required this.products,required this.onToggleCart});

  final String? title;
  final List<Product> products;
  final void Function()? onToggleCart;

  void selectProduct(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(
        product: product,
        onToggleCart: onToggleCart,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(
          product: products[index],
          onProductSelected: (product) {
            selectProduct(context, product);
          }),
    );

    if (products.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
