import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); // initial value

  bool toggleMealFavoriteStatus(Meal meal) {
    // method to change initial value
    final mealisFavorite = state.contains(meal);

    if (mealisFavorite) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); // state holds the data i.e list of meal
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// when the value to be returned is dynamic
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
