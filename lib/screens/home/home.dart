import 'package:app_firebase/models/coffee.dart';
import 'package:app_firebase/screens/home/coffee_list.dart';
import 'package:app_firebase/screens/home/settings_form.dart';
import 'package:app_firebase/services/auth.dart';
import 'package:app_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {

    _showSettingsButton(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 30.0),
          child: SettingsForm()
        );
      });
    }


    return StreamProvider<List<Coffee>?>.value(
      // value: DataBaseService(null).coffee,
       value: DataBaseService(null).coffee,
      // ignore: prefer_const_literals_to_create_immutables
    
      initialData: null,
      child: Scaffold(
        // backgroundColor: Colors.grey[600],
        appBar: AppBar(
          title: Text("home page"),
          // backgroundColor: Colors.grey[700],
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async{
                await authService.signOut();
              },
              label: Text("logout",style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () =>_showSettingsButton()
              ,
              label: Text("Settings",style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
        body: CoffeeList(),
      ),
    );
  }
}