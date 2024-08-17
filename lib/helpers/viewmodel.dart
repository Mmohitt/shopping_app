import 'package:e_comm_app/data/dao.dart';
import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:flutter/cupertino.dart';

class MasterDataViewModel extends ChangeNotifier {
  final Repository _repository;
  final dao = CategoryDao();
  List<dynamic> _categories = [];
  List<dynamic> _products = [];

  MasterDataViewModel(this._repository);

  List<dynamic> get categories => _categories;
  List<dynamic> get products => _products;

  Future<void> fetchAndSaveCategoriesData() async {
    try {
      final data = await _repository.makeCategoriesApiRequest();
      _categories = data;
      saveCategories(_categories);
      notifyListeners(); // Notify UI of data change
    } on Exception catch (e) {
      // Handle errors appropriately (e.g., show a toast or retry)
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> fetchAndSaveProductsData() async {
    try {
      final data = await _repository.makeProductsApiRequest();
      _products = data;
      saveProducts(_products);
      notifyListeners(); // Notify UI of data change
    } on Exception catch (e) {
      // Handle errors appropriately (e.g., show a toast or retry)
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> saveCategories(List<dynamic> categories) async {
    for (var category in categories) {
      try {
        await dao.insertCategory(category);
      } catch (e) {
        print('Error inserting category: $e');
      }
    }
  }

  void saveProducts(List<dynamic> products) {}
}