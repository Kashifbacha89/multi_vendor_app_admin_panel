import 'package:flutter/material.dart';
class OrdersScreen extends StatelessWidget {
  static const String routeName='/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Orders',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
