import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:e_comm_app/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/screens/categories.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.categories});

  final List<Category> categories ;

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final repository = Repository();
  int _selectedPageIndex = 0;

  late Widget activePage;

  @override
  void initState() {
    super.initState();
    activePage = CategoriesScreen(
      availableCategories: widget.categories,
    );
  }

  var activePageTitle = 'categories';

  void _selectPage(int index) {
    _selectedPageIndex = index;
    if (_selectedPageIndex == 1) {
      openCart();
    } else {
      setState(() {
        activePage = CategoriesScreen(
          availableCategories: widget.categories,
        );
      });
    }
  }

  void _onToggleCart() {
    openCart();
  }

  void openCart() async {
    final masterDataViewModel = MasterDataViewModel(repository);
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
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Cart'),
        ],
      ),
    );
  }
}
