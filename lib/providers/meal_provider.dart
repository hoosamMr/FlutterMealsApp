import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
//after typing in the terminal -> flutter pob add flutter_riverpod

final mealsProvider = Provider((ref){
  return dummyMeals;
});