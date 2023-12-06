import 'package:flutter/material.dart';
//import 'package:meals/screens/tabs.dart';
//import 'package:meals/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilter});

  final Map<Filter, bool> currentFilter;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterdSet = false;
  var _vagetarianFilterdSet = false;
  var _veganFilterdSet = false;

  @override
  void initState() {
    super.initState();//174 applaying Filters
    _glutenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilterdSet = widget.currentFilter[Filter.lactoseFree]!;
    _vagetarianFilterdSet = widget.currentFilter[Filter.vegetarian]!;
    _veganFilterdSet =widget.currentFilter[Filter.vegan]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      /*ADDING drawer here is cansling the back botton.*/

      // drawer: MainDrawer(
      //   onSelectScreen: (indentefier) {
      //     Navigator.of(context).pop();
      //     if (indentefier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),

      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterdSet,
            Filter.vegetarian: _veganFilterdSet,
            Filter.vegan: _veganFilterdSet,
          });
          return false;
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (isCheked) {
              setState(() {
                _glutenFreeFilterSet = isCheked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _lactoseFreeFilterdSet,
            onChanged: (isCheked) {
              setState(() {
                _lactoseFreeFilterdSet = isCheked;
              });
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _vagetarianFilterdSet,
            onChanged: (isCheked) {
              setState(() {
                _vagetarianFilterdSet = isCheked;
              });
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterdSet,
            onChanged: (isCheked) {
              setState(() {
                _veganFilterdSet = isCheked;
              });
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ]),
      ),
    );
  }
}
