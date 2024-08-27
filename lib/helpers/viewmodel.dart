import 'package:e_comm_app/data/dao.dart';
import 'package:e_comm_app/di/locator.dart';
import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class MasterDataViewModel extends ChangeNotifier {
  final _repository = getIt<Repository>();
  final categoryDao = getIt<CategoryDao>();
  final productDao = getIt<ProductDao>();
  final cartDao = getIt<CartDao>();
  List<Category> _categories = [];
  List<Product> _products = [];

  MasterDataViewModel();

  Future<void> fetchAndSaveCategoriesData() async {

    final existingCategories = await categoryDao.getAllCategory();

    if(existingCategories.isEmpty) {
      try {
        final data = await _repository.makeCategoriesApiRequest();
        _categories = data;
        await saveCategories(_categories);
        notifyListeners();
      } on Exception catch (e) {
        debugPrint('Error fetching categories: $e');
      }
    }
  }

  Future<void> fetchAndSaveProductsData() async {

    final existingProducts = await productDao.getAllProduct();

    if(existingProducts.isEmpty) {
      try {
        final data = await _repository.makeProductsApiRequest();
        _products = data;
        await saveProducts(_products);
        notifyListeners();
      } on Exception catch (e) {
        debugPrint('Error fetching products: $e');
      }
    }
  }

  Future<void> saveCategories(List<Category> categories) async {
    for (var category in categories) {
      try {
        await categoryDao.insertCategory(category);
      } catch (e) {
        print('Error inserting category: $e');
      }
    }
  }

  Future<void> saveProducts(List<Product> products) async {
    for( var product in products) {
      try {
        await productDao.insertProduct(product);
      } catch (e) {
        print('Error inserting products: $e');
      }
    }
  }

  Future<List<Category>> getAllCategories() async {
    return await categoryDao.getAllCategory();
  }

  Future<List<Product>> getProductsFromCategory(String category) {
    return productDao.getProductFromCategory(category);
  }

  Future<List<Product>> getAllCartProduct() async {
    return await cartDao.getAllCartProduct();
  }

  Future<bool> isProductInCart(int productId) async {
    return await cartDao.isProductInCart(productId);
  }

  Future<void> insertProduct(Product product) async {
    await cartDao.insertProduct(product);
  }

  Future<void> deleteProduct(int productId) async {
    await cartDao.deleteProduct(productId);
  }
}