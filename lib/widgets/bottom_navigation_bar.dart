import 'package:flutter/material.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/messenger_screen.dart';
import 'package:food_app/screens/profile_screen.dart';

import '../screens/products_overview_screen.dart';




class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);
  static const routeName='nav_var';

  @override
  State<MyBottomNavBar> createState() => MyBottomNavBarState();
}

class MyBottomNavBarState extends State<MyBottomNavBar> {
  static int bottomNavigationTabIndex = 0;
  static void selectPage(BuildContext context, int index) {
    MyBottomNavBarState? stateObject =
        context.findAncestorStateOfType<MyBottomNavBarState>();
    stateObject?.setState(() {
      bottomNavigationTabIndex = index;
    });
    print("called nav");
  }

  static void refresh(BuildContext context) {
    MyBottomNavBarState? stateObject =
        context.findAncestorStateOfType<MyBottomNavBarState>();
    stateObject?.setState(() {
      bottomNavigationTabIndex = 0;
      bottomNavigationTabIndex = 1;
    });
  }

  static  List<Widget> widgetOptions = <Widget>[
    // CustomNavigationDrawer(),
    ProductsOverviewScreen(),
    const MessengerScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  //Implementing Bottom Navigation Bar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widgetOptions.elementAt(bottomNavigationTabIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                ),
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.message),
                icon: Icon(Icons.message_outlined),
                label: "Messanger",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.shopping_cart),
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: "My Foody",
              ),
            ],
            currentIndex: bottomNavigationTabIndex,
            onTap: (int index) {
              setState(() {
                bottomNavigationTabIndex = index;
              });
            }),
      ),
    );
  }
}
