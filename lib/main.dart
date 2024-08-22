import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/models/category.dart';
import 'package:e_comm_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 131, 57, 0)),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    final repository = Repository();
    final masterDataViewModel = MasterDataViewModel(repository);

    Future<List<Category>> fetchAndSaveCategoriesData() async {
      await masterDataViewModel.fetchAndSaveCategoriesData();
      await masterDataViewModel.fetchAndSaveProductsData();
      return masterDataViewModel.getAllCategories();
    }

    return MaterialApp(
        theme: theme,
        home: FutureBuilder<List<Category>>(
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
        )
    );
  }
}
