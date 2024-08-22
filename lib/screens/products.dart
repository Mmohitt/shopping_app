import 'package:e_comm_app/models/product.dart';
import 'package:e_comm_app/screens/product_details.dart';
import 'package:e_comm_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key,
        this.title,
        required this.products,required this.onToggleCart});

  final String? title;
  final List<Product> products;
  final void Function()? onToggleCart;

  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {

  var _ratingAboveFour = false;
  var _priceLessThan100 = false;

  @override
  void initState() {
    insertData();
    super.initState();
  }

  final subject = BehaviorSubject<List<Product>>();
  ValueStream<List<Product>> get productStream => subject.stream;

  void insertData() {
    List<Product> filteredProducts = widget.products;
    if(_ratingAboveFour) {
      filteredProducts = filteredProducts.where((product) {
        if(product.rating.rate < 4) return false;
        return true;
      }).toList();
    }
    if(_priceLessThan100) {
      filteredProducts = filteredProducts.where((product) {
        if(product.price > 100) return false;
        return true;
      }).toList();
    }
    subject.add(filteredProducts);
  }

  void selectProduct(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(
        product: product,
        onToggleCart: widget.onToggleCart,
      ),
    ));
  }


  void _showFilters(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SwitchListTile(
                      value: _ratingAboveFour,
                      onChanged: (isChecked) {
                        setState(() {
                          _ratingAboveFour = isChecked;
                          insertData();
                        });
                      },
                      title: Text(
                        'Rating > 4',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      subtitle: Text('Only include products rated above four.',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground)),
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      contentPadding: const EdgeInsets.only(left: 34, right: 22),
                    ),
                    SwitchListTile(
                      value: _priceLessThan100,
                      onChanged: (isChecked) {
                        setState(() {
                          _priceLessThan100 = isChecked;
                          insertData();
                        });
                      },
                      title: Text(
                        'Price < 100',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      subtitle: Text('Price less than 100',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground)),
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      contentPadding: const EdgeInsets.only(left: 34, right: 22),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = StreamBuilder<List<Product>>(
      stream: productStream,
      builder: (context, snapshot) {
        final list = snapshot.data ?? [];
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, index) => ProductItem(
              product: list[index],
              onProductSelected: (product) {
                selectProduct(context, product);
              }),
        );
      }
    );

    if (subject.value.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
        IconButton(
        icon: const Icon(Icons.filter_alt), onPressed: () {
          _showFilters(context);
        },
      ),
        ],
      ),
      body: content,
    );
  }
}
