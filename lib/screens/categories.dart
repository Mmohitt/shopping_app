import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_comm_app/di/locator.dart';
import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/route.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/models/product.dart';
import 'package:e_comm_app/screens/filters.dart';
import 'package:e_comm_app/screens/products.dart';
import 'package:e_comm_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
   const CategoriesScreen(
      {super.key,required this.availableCategories, required this.selectedFilters});

  final List<Category> availableCategories;
  final Map<Filter, bool> selectedFilters;

  void _selectCategory(BuildContext context, Category category) async {
    final masterDataViewModel = getIt<MasterDataViewModel>();

    final products = await masterDataViewModel.getProductsFromCategory(category.name);
    List<Product> filteredProducts = products;
    if(selectedFilters[Filter.rating]!) {
      filteredProducts = products.where((product) {
        if(product.rating.rate < 4) return false;
        return true;
      }).toList();
    }
    if(selectedFilters[Filter.sorting]!) {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    }
    context.router.push(ProductsRoute(title: category.name , products: filteredProducts, onToggleCart: () {}));
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
