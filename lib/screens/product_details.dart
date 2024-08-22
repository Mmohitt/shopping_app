import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:e_comm_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(
      {super.key, required this.product, required this.onToggleCart});

  final Product product;
  final void Function()? onToggleCart;

  Future<void> _addAndRemoveFromCart(BuildContext context ,Product product) async {
    final repository = Repository();
    final masterDataViewModel = MasterDataViewModel(repository);
    if(await masterDataViewModel.isProductInCart(product.id)){
      await masterDataViewModel.deleteProduct(product.id);
      _showInfoMessage(context, 'product is removed from cart');
    }
    else {
      await masterDataViewModel.insertProduct(product);
      _showInfoMessage(context, 'product is added in cart');
    }
    if(onToggleCart != null){
      onToggleCart!();
    }
  }

  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          actions: [
            IconButton(
                onPressed: () {
                  _addAndRemoveFromCart(context, product);
                },
                icon: const Icon(Icons.add_shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
                Container(
                 child: Text(product.description,
                     textAlign: TextAlign.center,
                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                       color: Theme.of(context).colorScheme.onBackground,
                     )),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                )

            ],
          ),
        ));
  }
}
