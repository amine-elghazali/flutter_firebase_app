import 'package:app_firebase/services/auth.dart';
import 'package:app_firebase/shared/constant.dart';
import 'package:app_firebase/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  late Function switchView;

  Register(this.switchView);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  
  String errorMessage = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        actions: [
          TextButton.icon(
          icon: Icon(Icons.person,color: Colors.white,), 
          label: Text('Sign in',style: TextStyle(color: Colors.white),),
          onPressed: (){
            widget.switchView();
          }
          )
        ],
      ),
      body: Container(
          padding : EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        //   child: ElevatedButton(
            
        //     onPressed: ()async {
        //       dynamic result = await authService.signInAnon();
        //       if(result == null){
        //         print("error during sign in !");
        //       }
        //       else {
        //         print("signed in");
        //         print(result.uid);
        //       }
        //     },
        //     child: Text("sign in"),
        //   ),
        // ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (value) { if (value!.isEmpty) return 'enter value ! ';},
                onChanged: (value){
                  setState(
                    () => email = value
                  );
                  print(email);
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,  // Hiding the input
                validator: (value)=> value!.length<6 ? 'Enter more than 6 characters' : null,
                onChanged: (value){
                  setState(
                    () => password = value
                  );
                  print(password);
                },

              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                child: Text('Sign up',style: TextStyle(
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);

                    dynamic result = await authService.registerWithEmailAndPassword(email, password);

                      if( result == null ){
                        setState(() {
                          errorMessage = 'verify fields !';
                          loading = false;
                        });
                      }
                  }
                },
              ),
              SizedBox(height:10.0),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )
            ],
          )
        ),
      )
    );
  }
}