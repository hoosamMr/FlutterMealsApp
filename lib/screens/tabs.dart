import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    // final isExisting = _favoriteMeals.contains(meal);
    // if(isExisting) {
    //  setState(() {
    //     _favoriteMeals.remove(meal);
    //     _showInfoMessage('${meal.title} deleted from favoret list');
    //  });
    // } else {
    //   setState(() {
    //     _favoriteMeals.add(meal);
    //     _showInfoMessage('${meal.title} added to favoret list');
    //   });
    // }
    _favoriteMeals.contains(meal)
        ? setState(() {
            _favoriteMeals.remove(meal);
            _showInfoMessage('${meal.title} deleted from favoret list');
          })
        : setState(() {
            _favoriteMeals.add(meal);
            _showInfoMessage('${meal.title} added to favoret list');
          });
    // setState(() {
    //   _favoriteMeals.contains(meal)
    //       ? _favoriteMeals.remove(meal)
    //       : _favoriteMeals.add(meal);
    // });
  }

  //var activePageTitle = 'Categories';
  ///*creating this line here cusing a bug that dosn't change the title*/
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      //activePageTitle = 'Favorites';

      // switch (_selectedPageIndex) {
      //   case 0:
      //    activePageTitle = 'Categories';
      //   case  1:
      //     activePageTitle = 'Favorites';
      //     break;
      //   default:
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      ); //lucture 165 passing a function through widgets
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
        drawer: const MainDrawer(),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex:
            _selectedPageIndex, //this coe to highLight the selected icon.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
