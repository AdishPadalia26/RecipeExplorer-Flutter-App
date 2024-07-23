import 'package:daily_meals/main_drawer.dart';
import 'package:daily_meals/screens/Categories_screen.dart';
import 'package:daily_meals/screens/favourites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/meal.dart';

// class TabBarScreen extends StatefulWidget {
//   const TabBarScreen({Key? key}) : super(key: key);

//   @override
//   State<TabBarScreen> createState() => _TabBarScreenState();
// }

// class _TabBarScreenState extends State<TabBarScreen> {
//   //Upper Tab Bar
//   // @override
//   // Widget build(BuildContext context) {
//   //   return DefaultTabController(
//   //       length: 2,
//   //       child: Scaffold(
//   //         appBar: AppBar(
//   //           title: const Text('Meals'),
//   //           bottom: TabBar(tabs: <Widget>[
//   //             Tab(icon: Icon(Icons.category), text: 'Categories'),
//   //             Tab(
//   //               icon: Icon(Icons.star),
//   //               text: 'Favourites',
//   //             ),
//   //           ]),
//   //         ),
//   //         body: TabBarView(children: <Widget>[
//   //           CategoriesScreen(),
//   //           FavouriteScreen(),
//   //         ]),
//   //       ));
//   // }

//   //Bottom Tabs Bar

class TabBarScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabBarScreen(this.favouriteMeals);
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      'Categories',
      'Favourites',
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[index]),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: <Widget>[CategoriesScreen(), FavouriteScreen(widget.favouriteMeals)],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourites',
              )
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.all(5.0),
          ),
        ),
      ),
    );
  }
}
