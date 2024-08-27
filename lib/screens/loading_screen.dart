
import 'package:auto_route/annotations.dart';
import 'package:e_comm_app/di/locator.dart';
import 'package:e_comm_app/screens/tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/repository.dart';
import '../helpers/viewmodel.dart';
import '../models/category.dart';

@RoutePage()
class LoadingScreen extends StatefulWidget {
   const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final masterDataViewModel = getIt<MasterDataViewModel>();

  Future<List<Category>> fetchAndSaveCategoriesData() async {
    await masterDataViewModel.fetchAndSaveCategoriesData();
    await masterDataViewModel.fetchAndSaveProductsData();
    return masterDataViewModel.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future:  fetchAndSaveCategoriesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Category> categories = snapshot.data!;
          return TabsScreen(categories: categories);
        }
      },
    );
  }
}
