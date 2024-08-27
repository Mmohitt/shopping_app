import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:e_comm_app/screens/filters.dart';
import 'package:e_comm_app/screens/products.dart';
import 'package:e_comm_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/screens/categories.dart';

import '../di/locator.dart';

const kInitialFilters = {
  Filter.rating: false,
  Filter.sorting: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.categories});

  final List<Category> categories ;

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  late Widget activePage;

  @override
  void initState() {
    super.initState();
    activePage = CategoriesScreen(
      availableCategories: widget.categories,
      selectedFilters: _selectedFilters,
    );
  }

  var activePageTitle = 'Categories';

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
        activePage = CategoriesScreen(
          availableCategories: widget.categories,
          selectedFilters: _selectedFilters,
        );
      });
    }
  }

  void _selectPage(int index) {
    _selectedPageIndex = index;
    if (_selectedPageIndex == 1) {
      openCart();
    } else {
      setState(() {
        activePage = CategoriesScreen(
          availableCategories: widget.categories,
          selectedFilters: _selectedFilters,
        );
        activePageTitle = 'Categories';
      });
    }
  }

  void _onToggleCart() {
    openCart();
  }

  void openCart() async {
    final masterDataViewModel = getIt<MasterDataViewModel>();
    final cartProducts = await masterDataViewModel.cartDao.getAllCartProduct();
    setState(() {
      activePage = ProductsScreen(
        products: cartProducts,
        onToggleCart: _onToggleCart,
      );
      activePageTitle = 'Cart';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}
