import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

/*-----necessary riverpod Notifire provider imports-----*/
//step 1
import '../providers/favorites_provider.dart'; //to set up the widget from state less to ConsumerWidget.
import 'package:flutter_riverpod/flutter_riverpod.dart'; //to accses the notifier ref.

/*------------------------------------------------------*/
class MealDetailsScreen extends ConsumerWidget
/*
step 2:
change the StatelessWidget to ConsumerWidget
*/
{
  const MealDetailsScreen({
    super.key,
    required this.meal,
    //required this.onToggleFavorite,
  });

  final Meal meal;
  //final void Function(Meal meal) onToggleFavorite;
  @override
  Widget build(BuildContext context, WidgetRef ref)
  /*
  step 3:
    add the (WidgetRef ref) argument.
  */
  {
    final isFavorite = ref.watch(favoritesMealsProvider).contains(meal);
    return Scaffold(
        appBar: AppBar(
            title: Text(
              meal.title,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    //onToggleFavorite(meal);
                    final wasAdded =
                        ref.watch(favoritesMealsProvider).contains(meal);
                    ref
                        .read(favoritesMealsProvider.notifier)
                        .toggleMealFavoriteStatus(meal);

                    //now we can copy the message of ScaffoldMessenger from the tabs to here.

                    ScaffoldMessenger.of(context).clearMaterialBanners();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(wasAdded
                            ? '${meal.title} removed from your favoritesMeals'
                            : '${meal.title} added to your favoritesMeals'),
                      ),
                    );
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns:/*anumation*/ Tween<double>(begin: 0.5,end: 1).animate(animation),
                        child: child,
                      );
                    },
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      key: ValueKey(isFavorite),
                    ),
                  ))
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
        ));
  }
}
