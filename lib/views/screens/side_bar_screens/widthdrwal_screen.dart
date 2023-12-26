import 'package:flutter/material.dart';
class WithdrawalScreen extends StatelessWidget {
  static const String routeName='/withdrawal';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Withdrawal',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
