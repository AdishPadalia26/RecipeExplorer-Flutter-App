import 'package:daily_meals/models/meal.dart';
import 'package:daily_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../dummy_data.dart';

class ReceipeScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  ReceipeScreen(this.availableMeals);
  @override
  State<ReceipeScreen> createState() => _ReceipeScreenState();
}

class _ReceipeScreenState extends State<ReceipeScreen> {
  String id = '';
  String title = '';
  List<Meal> displayedMeals = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = routeArgs['id'];
    title = routeArgs['title'];
    displayedMeals = widget.availableMeals.where(((meal) {
      return meal.categories.contains(id);
    })).toList();
    super.didChangeDependencies();
  }

  void removeItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          title,
        )),
        body: ListView.builder(
          itemCount: displayedMeals.length,
          itemBuilder: ((context, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
              //removeItem: removeItem,
            );
          }),
        ));
  }
}



  //First Method of passing data and Navigation
  // final String categoryId;
  // final String title;
  // ReceipeScreen(this.categoryId, this.title);
