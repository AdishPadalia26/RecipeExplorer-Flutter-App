import 'package:daily_meals/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/meal.dart';

class MealItemScreen extends StatelessWidget {
  static const routeName = '/meal_item';
  final Function toggleFavourite;
  final Function isFavourite;
  MealItemScreen(this.toggleFavourite, this.isFavourite);
  Widget _buildTitle(BuildContext context, title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer(child) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54)),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == routeArgs);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${selectedMeal.title}',
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildTitle(context, 'Ingredients'),
            _buildContainer(ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                }))),
            _buildTitle(context, 'Steps'),
            _buildContainer(ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            '# ${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                })),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(selectedMeal.id);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>toggleFavourite(routeArgs),child: Icon(isFavourite(routeArgs)?Icons.star:Icons.star_border),),
    );
  }
}
