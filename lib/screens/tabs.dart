import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const KInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

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
  Map<Filter, bool> _selectedFilters = KInitialFilters;
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

  void _setScreen(String identifier) async {
    Navigator.of(context)
        .pop(); //this line added here to clode the drawer after exiting the filterScreen, now you can delete the else statment.
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        //pushReplacement used to replace the screen in the widgets stuck instude of push widget over widget.
        MaterialPageRoute(
          builder: (ctx) =>  FiltersScreen(currentFilter: _selectedFilters,),
        ),
      );
      setState(() {
        _selectedFilters = result ?? KInitialFilters;
      });
    } /*else {
      Navigator.of(context).pop();
    }*/
  }

  @override
  Widget build(BuildContext context) {
   
    final availableMeals = dummyMeals.where((meal){

      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
      
      
    
    }).toList();
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
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
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
