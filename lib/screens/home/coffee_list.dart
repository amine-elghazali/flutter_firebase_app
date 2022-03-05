import 'package:app_firebase/models/coffee.dart';
import 'package:app_firebase/screens/home/one_coffe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CoffeeList extends StatefulWidget {
  const CoffeeList({ Key? key }) : super(key: key);

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {



  @override
  Widget build(BuildContext context) {

  final coffeeList = Provider.of<List<Coffee>?>(context) ?? [];

  // print(coffeeList.docs);

  // print("test test");
  // coffeeList.forEach( (coffee) {
  //   print(coffee.name);
  //   print(coffee.sugars);
  //   print(coffee.strength);
  // });
  

    return ListView.builder(
      itemCount: coffeeList.length,
      itemBuilder: (context,index){
        return OneCoffee(coffeeList[index]);
      }
    );
  }
}