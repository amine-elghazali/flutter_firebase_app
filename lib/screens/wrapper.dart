import 'package:app_firebase/models/user.dart';
import 'package:app_firebase/screens/authenticate/authenticate.dart';
import 'package:app_firebase/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(user); 
    // return home or authenticate widget 

    if(user == null){
      return Authenticate();
    }else {
    return Home();
    }
  }
}