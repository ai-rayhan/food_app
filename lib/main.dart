import 'package:flutter/material.dart';
import 'package:food_app/constants/constant.dart';
import 'package:food_app/provider/Products.dart';
import 'package:food_app/screens/product_details_screen.dart';
import 'package:food_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import 'widgets/bottom_navigation_bar.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData.light().copyWith(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: colorcoffee,unselectedItemColor: colorcoffee)
        ),
        home: AuthScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          MyBottomNavBar.routeName:(context) => MyBottomNavBar(),
        },
      ),
    );
  }
}
