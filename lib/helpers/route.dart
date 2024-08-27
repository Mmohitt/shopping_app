
import 'package:auto_route/auto_route.dart';
import 'package:e_comm_app/screens/categories.dart';
import 'package:e_comm_app/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:e_comm_app/models/product.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/screens/loading_screen.dart';
import 'package:e_comm_app/screens/product_details.dart';
import '../screens/filters.dart';
part 'route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoadingRoute.page, initial: true),
    AutoRoute(page: CategoriesRoute.page),
    AutoRoute(page: ProductsRoute.page),
    AutoRoute(page: ProductDetailsRoute.page)
  ];
}