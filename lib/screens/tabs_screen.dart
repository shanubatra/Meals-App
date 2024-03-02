import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '../screens/favorites_screen.dart';
import '../screens/categories_screen.dart';

class TabScreen extends StatefulWidget {
  //const TabScreen({Key? key}) : super(key: key);

  final List<Meal> favoriteMeals;
  const TabScreen(this.favoriteMeals, {super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
    {
      'page': const CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreen(widget.favoriteMeals),
      'title': 'Favorites',
    },
  ];
    super.initState();
    
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'] as String),
          // bottom:
          // TabBar(
          //       labelColor: Colors.black,
          //       indicatorColor: Colors.black,
          //       tabs: [
          //         Tab(
          //           icon: Icon(Icons.category),
          //           text: 'Categories',
          //         ),
          //         Tab(
          //           icon: Icon(Icons.star),
          //           text: 'Favorites',
          //         ),
          //       ]),
        ),
        drawer: const MainDrawer(),
        body: _pages[_selectedPageIndex]['page'] as Widget
        // TabBarView(
        //   children: [
        //     CategoriesScreen(),
        //     FavoritesScreen(),
        //   ],
        // )
        ,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
        // bottomNavigationBar: Material(
        //   color: Theme.of(context).colorScheme.primary,
        //     child: TabBar(
        //         labelColor: Colors.black,
        //         indicatorColor: Colors.black,
        //         tabs: [
        //           Tab(
        //             icon: Icon(Icons.category),
        //             text: 'Categories',
        //           ),
        //           Tab(
        //             icon: Icon(Icons.star),
        //             text: 'Favorites',
        //           ),
        //         ]),
        //   ),
      ),
    );
  }
}
