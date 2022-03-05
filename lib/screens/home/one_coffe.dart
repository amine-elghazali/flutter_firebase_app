import 'package:flutter/material.dart';
import 'package:app_firebase/models/coffee.dart';

class OneCoffee extends StatelessWidget {

  final Coffee coffee;

  OneCoffee(this.coffee);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 5.0, 20, 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown[coffee.strength.toInt()],
          ),
          title: Text(coffee.name),
          subtitle: Text('Number of sugar pieces : ${coffee.sugars}'),
        ),
      ),
    );
  }
}