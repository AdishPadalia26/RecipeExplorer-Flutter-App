import 'package:daily_meals/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function(Map<String, bool>) setFilters;
  final Map<String, bool> filters;
  FiltersScreen(this.filters, this.setFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluttenFree = false;
  var _vegetarian = false;
  var _lactoseFree = false;
  var _vegan = false;
  @override
  void initState() {
    setState(() {
      widget.filters['gluten'] = _gluttenFree;
      widget.filters['lactose'] = _lactoseFree;
      widget.filters['vegan'] = _vegan;
      widget.filters['vegetarian'] = _vegetarian;
    });
    super.initState();
  }

  Widget _buildFilter(String title, String description, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> selectedFilters = {
                  'gluten': _gluttenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.setFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: const Text(
            "Adjust your meals",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildFilter(
            'Glutten-Free', 'Only included glutten-free meals.', _gluttenFree,
            (newValue) {
          setState(() {
            _gluttenFree = newValue;
          });
        }),
        _buildFilter(
            'Lactose-Free', 'Only included lactose-free meals.', _lactoseFree,
            (newValue) {
          setState(() {
            _lactoseFree = newValue;
          });
        }),
        _buildFilter('Vegan', 'Only included vegan meals.', _vegan, (newValue) {
          setState(() {
            _vegan = newValue;
          });
        }),
        _buildFilter(
            'Vegetarian', 'Only included vegetarian meals.', _vegetarian,
            (newValue) {
          setState(() {
            _vegetarian = newValue;
          });
        }),
      ]),
      drawer: MainDrawer(),
    );
  }
}
