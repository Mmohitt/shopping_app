import '../api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Repository {

  Future<dynamic> makeCategoriesApiRequest() async {
    try {
      final response = await APIService.instance.request(
        'products/categories',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        return response.data;
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
      return null;
    }
  }

  Future<dynamic> makeProductsApiRequest() async {
    try {
      final response = await APIService.instance.request(
        'products',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        return response.data;
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
      return null;
    }
  }

}