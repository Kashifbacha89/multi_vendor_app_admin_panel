import 'package:flutter/material.dart';
class DashboardScreen extends StatelessWidget {
  static const String routeName='/dashboard';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Dashboard',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
