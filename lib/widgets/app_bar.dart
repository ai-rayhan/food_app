import 'package:flutter/material.dart';

import '../constants/constant.dart';

class MyAppBar extends StatelessWidget {
   MyAppBar({super.key, required this.title,this.actions});
String title;
var actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title:  Text(title),
        backgroundColor: colorcoffee,
        automaticallyImplyLeading: false,
        actions: actions,
      );
  }
}