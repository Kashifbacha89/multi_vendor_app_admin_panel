import 'package:flutter/material.dart';
class ProductsScreen extends StatelessWidget {
  static const String routeName='/ProductsScreen';

  Widget _rowHeader(String text,int flex){
    return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade800,),
            color: Colors.yellow.shade900,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: Text('Products',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
          ),
          Row(
            children: [
              _rowHeader('IMAGE', 1),
              _rowHeader('NAME', 3),
              _rowHeader('PRICE', 2),
              _rowHeader('QUANTITY', 2),
              _rowHeader('ACTION', 1),
              _rowHeader('VIEW MORE', 1),
            ],
          )
        ],
      ),
    );
  }
}
