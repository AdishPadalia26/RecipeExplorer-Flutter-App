enum Complexity { Simple, Hard, Challenging }

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;

  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imageUrl,
      required this.ingredients,
      required this.complexity,
      required this.affordability,
      required this.duration,
      required this.steps,
      required this.isVegetarian,
      required this.isVegan,
      required this.isLactoseFree,
      required this.isGlutenFree});
}
