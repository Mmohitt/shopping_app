import 'dart:convert';

import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/models/product.dart';

import '../api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Repository {
  Future<List<Category>> makeCategoriesApiRequest() async {
    try {
      final response = await APIService.instance.request(
        'products/categories',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        List<Category> categories = (response.data as List)
            .map((categoryName) => Category(name: categoryName as String))
            .toList();
        return categories;
      } else {
        throw Exception(
            'Error ${response.statusCode}: ${response.statusMessage}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "error while loading categories",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }

  Future<List<Product>> makeProductsApiRequest() async {
    try {
      final response = await APIService.instance.request(
        'products',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception(
            'Error ${response.statusCode}: ${response.statusMessage}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "error while loading products",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }
}
