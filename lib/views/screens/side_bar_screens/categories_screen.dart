import 'package:flutter/material.dart';
class CategoriesScreen extends StatelessWidget {
  static const String routeName='/CategoriesScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Categories',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
