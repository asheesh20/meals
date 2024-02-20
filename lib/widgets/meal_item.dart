import 'package:flutter/material.dart';
//import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1); // 'Hello'+'World' => 'HelloWorld'
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip
          .hardEdge, // stack ignores the shape provided above , to fix clipbehaviour is used
      elevation: 2, // provide shadow behind the card
      child: InkWell(
        onTap: () {
          onSelectMeal(meal); // this meal is final Meal meal
        },
        child: Stack(
          // to position multiple widgets above each other  , also stack ignores the shape provided above , to fix clipbehaviour is used
          children: [
            Hero(
              // adding animation across different screens , must be added on 2 places , from and to
              tag: meal.id,
              child: FadeInImage(
                // bottom most widget
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 250, // 250
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0, // how child is postioned on FadeInImage ie Container
              left: 0, // how child is postioned on FadeInImage ie Container
              right: 0, // how child is postioned on FadeInImage ie Container
              child: Container(
                color: Colors.black54, // kind of transparent black color
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2, // max number of lines
                      textAlign: TextAlign.center,
                      softWrap: true, // Text wrapped in good looking way
                      overflow: TextOverflow
                          .ellipsis, // if exceeded than maxLines  then this shows => ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centers the widgets
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
