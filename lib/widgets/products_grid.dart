///modified main data

import 'package:flutter/material.dart';
import 'package:food_app/constants/constant.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';

// import '../Provider/Products.dart';
import '../provider/Products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  //  final bool showFavs;
  // ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
///////////////// instance product provider////////////
    final products = Provider.of<Products>(context).items;
    // final products = showFavs?productsData.favoriteItems: productsData.items;
///////////////////

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: colorOrange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                height: 120.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16.0),
                  children: [
                    CategoryCard(
                      title: 'Pizza',
                      image: 'assets/images/pizza.jpg',
                    ),
                    SizedBox(width: 16.0),
                    CategoryCard(
                      title: 'Salmon',
                      image: 'assets/images/salmon.jpg',
                    ),
                    SizedBox(width: 16.0),
                    CategoryCard(
                      title: 'Chicken',
                      image: 'assets/images/banner.png',
                    ),
                    SizedBox(width: 16.0),
                    CategoryCard(
                      title: 'Fish',
                      image: 'assets/images/fish.png',
                    ),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  'Featured products',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: colorOrange,
                  ),
                ),
              ]),
              SizedBox(height: 16.0),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // create: (context) => products[i],
              value: products[i],
              child: ProductItem(
                products[i].id,
                products[i].title,
                products[i].imageUrl,
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kIsWeb ? 5 : 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  CategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 183, 255),
          ),
        ),
      ),
    );
  }
}
