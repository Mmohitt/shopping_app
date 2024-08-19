import 'package:flutter/material.dart';

enum Filter { rating, sorting }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _ratingAboveFour = false;
  var _priceLowToHigh = false;

  @override
  void initState() {
    super.initState();
    _ratingAboveFour = widget.currentFilters[Filter.rating]!;
    _priceLowToHigh = widget.currentFilters[Filter.sorting]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.rating: _ratingAboveFour,
            Filter.sorting: _priceLowToHigh,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _ratingAboveFour,
              onChanged: (isChecked) {
                setState(() {
                  _ratingAboveFour = isChecked;
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
              value: _priceLowToHigh,
              onChanged: (isChecked) {
                setState(() {
                  _priceLowToHigh = isChecked;
                });
              },
              title: Text(
                'Sort Asc',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Sort products price low to high',
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
}
