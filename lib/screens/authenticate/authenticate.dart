import 'package:app_firebase/screens/authenticate/register.dart';
import 'package:app_firebase/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInPage = true ; 

  void switchView(){
    print(this.showSignInPage);
    setState( ()=> showSignInPage = !showSignInPage );
  }

  @override
  Widget build(BuildContext context) {

    if( showSignInPage ){
      return SignIn(switchView);
    }else{
      return Register(switchView);
    }

  }
}