//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync:
          this, //this class    // makes sure that this animation executes for every frame (typically 60 times per second)
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, // set as default , but adding here explicitly
      upperBound: 1, // set as default , but adding here explicitly
    );

    _animationController.forward(); // starts the animation
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      // Navigator.push(context , route) , // route caonatins a widget which
      MaterialPageRoute(
        // is pushed to the top of screen stack using  MaterialPageRoute
        builder: (ctx) => MealsScreen(
          title: category.title, // appbar title
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, // horizontally spacing
          mainAxisSpacing: 20, // verically spacing
        ), // SilverGridDelegateWith -> set no. of columns
        children: [
          // ...availableCategories.map((abc) => CategoryGridItem(category: abc)).toList(),
          for (final category /* or abc */ in availableCategories)
            CategoryGridItem(
                category: category /* or abc */,
                onSelectCategory: () {
                  _selectCategory(context, category);
                }),
        ],
      ),
      builder: (context,
              child) => /*
      Padding(
        padding: EdgeInsets.only(
          top: 100 - _animationController.value * 100
          ),)
          */
          // The below method is optimised one
          SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child /* this child is builder's child i.e GridView */,
      ),
    );
  }
}
