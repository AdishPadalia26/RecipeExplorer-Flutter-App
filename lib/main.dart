import 'package:daily_meals/dummy_data.dart';
import 'package:daily_meals/models/meal.dart';
import 'package:daily_meals/screens/Categories_screen.dart';
import 'package:daily_meals/screens/filters_screen.dart';
import 'package:daily_meals/screens/meal_item_screen.dart';
import 'package:daily_meals/screens/tab_bar_screen.dart';
import 'package:daily_meals/widgets/categoryItem.dart';
import 'package:daily_meals/screens/receipe_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
    });
    availableMeals = DUMMY_MEALS.where((meal) {
      if (_filters['gluten'] as bool && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactose'] as bool && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegan'] as bool && !meal.isVegan) {
        return false;
      }
      if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  void _toggleFavourites(String mealId) {
    final existingIndex =
        favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isfavourite(String mealId) {
    return favouriteMeals.any((element) => element.id == mealId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.amber, // Your accent color
        ),
        textTheme: const TextTheme(
            headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1))),
      ),
      home: TabBarScreen(favouriteMeals),
      routes: {
        CategoryItem.screenName: ((context) => ReceipeScreen(availableMeals)),
        MealItemScreen.routeName: (context) => MealItemScreen(_toggleFavourites,_isfavourite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilter),
      },
    );
  }
}
