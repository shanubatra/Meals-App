import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
//import '../dummy_data.dart';
import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  //const MealsScreen({Key? key}) : super(key: key);

  final List<Meal> availableMeals;
  const MealsScreen(this.availableMeals, {super.key});
  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {

  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedInitState= false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitState){
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitState=true;
    }
    super.didChangeDependencies();    
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id==mealId);
    });
  }

  
  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
            title: displayedMeals[index].title,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
