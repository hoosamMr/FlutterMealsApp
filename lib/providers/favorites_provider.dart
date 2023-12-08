import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealsNotifire extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifire() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealFavorite = state.contains(meal);
    if (mealFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
    // state.contains(meal) ? state = state.where((m)=>m.id != meal.id).toList() : state = [...state,meal];
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifire, List<Meal>>(
  (ref) {
    return FavoritesMealsNotifire();
  },
);
