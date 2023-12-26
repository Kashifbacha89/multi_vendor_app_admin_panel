import 'package:flutter/material.dart';
class ProductsScreen extends StatelessWidget {
  static const String routeName='/ProductsScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Products',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
