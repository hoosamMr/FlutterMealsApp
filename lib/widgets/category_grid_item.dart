import 'package:flutter/material.dart';
//import 'package:meals/main.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    
    BorderRadius br = BorderRadius.circular(16);
    return InkWell(
      
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,//flash efect!!
      borderRadius: br,
      
      child: Container(
        alignment: FractionalOffset.center,//i added this line to center the text on the center
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: br,
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text( 
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),textAlign: TextAlign.center,         
        ),
      ),
    );
  }
}
