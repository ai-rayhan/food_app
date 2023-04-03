import 'package:flutter/material.dart';
import 'package:food_app/constants/constant.dart';
import 'package:food_app/provider/Products.dart';
import 'package:food_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
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
        theme: ThemeData(
          primarySwatch:Colors.blue,
          //   MaterialColor(0XFF0AA1DD, {
          //   // 50:Color(0XFF0AA1DD),
          // }),
          // fontFamily: 'Poppins',
         iconTheme: IconThemeData(
          color: primaryColorBlue,
         ),
          scaffoldBackgroundColor: Color.fromARGB(255, 229, 246, 250),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Color(0XFF0AA1DD)
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              color: Color(0XFF0AA1DD)
            ),
            displayMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: const Color(0XFF0AA1DD),
            ),
          ),
        ),
        home: AuthScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
        },
      ),
    );
  }
}
