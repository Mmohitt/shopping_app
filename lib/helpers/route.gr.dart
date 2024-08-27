// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoriesScreen(
          key: args.key,
          availableCategories: args.availableCategories,
          selectedFilters: args.selectedFilters,
        ),
      );
    },
    LoadingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoadingScreen(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductDetailsScreen(
          key: args.key,
          product: args.product,
          onToggleCart: args.onToggleCart,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductsScreen(
          key: args.key,
          title: args.title,
          products: args.products,
          onToggleCart: args.onToggleCart,
        ),
      );
    },
  };
}

/// generated route for
/// [CategoriesScreen]
class CategoriesRoute extends PageRouteInfo<CategoriesRouteArgs> {
  CategoriesRoute({
    Key? key,
    required List<Category> availableCategories,
    required Map<Filter, bool> selectedFilters,
    List<PageRouteInfo>? children,
  }) : super(
          CategoriesRoute.name,
          args: CategoriesRouteArgs(
            key: key,
            availableCategories: availableCategories,
            selectedFilters: selectedFilters,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<CategoriesRouteArgs> page =
      PageInfo<CategoriesRouteArgs>(name);
}

class CategoriesRouteArgs {
  const CategoriesRouteArgs({
    this.key,
    required this.availableCategories,
    required this.selectedFilters,
  });

  final Key? key;

  final List<Category> availableCategories;

  final Map<Filter, bool> selectedFilters;

  @override
  String toString() {
    return 'CategoriesRouteArgs{key: $key, availableCategories: $availableCategories, selectedFilters: $selectedFilters}';
  }
}

/// generated route for
/// [LoadingScreen]
class LoadingRoute extends PageRouteInfo<void> {
  const LoadingRoute({List<PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductDetailsScreen]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    Key? key,
    required Product product,
    required void Function()? onToggleCart,
    List<PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
            onToggleCart: onToggleCart,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static const PageInfo<ProductDetailsRouteArgs> page =
      PageInfo<ProductDetailsRouteArgs>(name);
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.product,
    required this.onToggleCart,
  });

  final Key? key;

  final Product product;

  final void Function()? onToggleCart;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product, onToggleCart: $onToggleCart}';
  }
}

/// generated route for
/// [ProductsScreen]
class ProductsRoute extends PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    Key? key,
    String? title,
    required List<Product> products,
    required void Function()? onToggleCart,
    List<PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            key: key,
            title: title,
            products: products,
            onToggleCart: onToggleCart,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const PageInfo<ProductsRouteArgs> page =
      PageInfo<ProductsRouteArgs>(name);
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.key,
    this.title,
    required this.products,
    required this.onToggleCart,
  });

  final Key? key;

  final String? title;

  final List<Product> products;

  final void Function()? onToggleCart;

  @override
  String toString() {
    return 'ProductsRouteArgs{key: $key, title: $title, products: $products, onToggleCart: $onToggleCart}';
  }
}
