import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/screens/products.dart';
import 'package:e_comm_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
   const CategoriesScreen(
      {super.key,required this.availableCategories});

  final List<Category> availableCategories;

  void _selectCategory(BuildContext context, Category category) async {
    final repository = Repository();
    final masterDataViewModel = MasterDataViewModel(repository);
    final products = await masterDataViewModel.getProductsFromCategory(category.name);

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProductsScreen(
            title: category.name,
            products: products, onToggleCart: () {  },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {

    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
