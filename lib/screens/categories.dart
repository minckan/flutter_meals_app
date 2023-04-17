import 'package:flutter/material.dart';
import 'package:meals_app_ver2/data/dummy_data.dart';
import 'package:meals_app_ver2/models/category.dart';
import 'package:meals_app_ver2/models/meal.dart';
import 'package:meals_app_ver2/screens/meals.dart';
import 'package:meals_app_ver2/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    void _selectCategory(BuildContext context, Category category) {
      final filteredMeals = availableMeals
          .where((meal) => meal.categories.contains(category.id))
          .toList();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleFavorite: onToggleFavorite,
          ),
        ),
      );
    }

    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}