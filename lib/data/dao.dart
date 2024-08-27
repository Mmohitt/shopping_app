import 'dart:async';

import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/models/product.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

class CategoryDao {
  static const String folderName = "Category";
  final _categoryFolder = intMapStoreFactory.store(folderName);


  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insertCategory(Category category) async{
    await  _categoryFolder.add(await _db, category.toJson());
    print('category Inserted successfully !!');
  }

  Future<List<Category>> getAllCategory() async {
    final recordSnapshot = await _categoryFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final category = Category.fromJson(snapshot.value);
      return category;
    }).toList();
  }
}

class ProductDao {
  static const String folderName = "Product";
  final _productFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertProduct(Product product) async {
    await _productFolder.add(await _db, {
    'id': product.id,
    'title': product.title,
    'price': product.price,
    'category': product.category,
    'description': product.description,
    'image': product.image,

    'rating': product.rating.toJson(),

    });
    print('product Inserted successfully !!');
  }

  Future<List<Product>> getAllProduct() async {
    final recordSnapshot = await _productFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final product = Product.fromJson(snapshot.value);
      return product;
    }).toList();
  }

  Future<List<Product>> getProductFromCategory(String category) async {
    final recordSnapshot = await _productFolder.find(await _db);
    return recordSnapshot.where((snapshot) => snapshot.value["category"] == category)
        .map((snapshot) {
      final product = Product.fromJson(snapshot.value);
      return product;
    }).toList();
  }
}

class CartDao {
  static const String folderName = "Cart";
  final _cartFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertProduct(Product product) async {
    await _cartFolder.add(await _db, {
    'id': product.id,
    'title': product.title,
    'price': product.price,
    'category': product.category,
    'description': product.description,
    'image': product.image,

    'rating': product.rating.toJson(),

    });
    print('product Inserted successfully !!');
  }

  Future<List<Product>> getAllCartProduct() async {
    final recordSnapshot = await _cartFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final product = Product.fromJson(snapshot.value);
      return product;
    }).toList();
  }

  Future<bool> isProductInCart(int productId) async {
    final recordSnapshot = await _cartFolder.find(await _db);
    return recordSnapshot.any((snapshot) => Product.fromJson(snapshot.value).id == productId);
  }

  Future deleteProduct(int productId) async {
    final finder = Finder(
      filter: Filter.equals('id', productId),
    );

    await _cartFolder.delete(await _db, finder: finder);
    print('Product deleted successfully!');
  }
}